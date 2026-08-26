Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA0EC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93E3280BEC;
	Wed, 26 Aug 2026 05:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jSRp581XyyMd; Wed, 26 Aug 2026 05:30:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722234;
	bh=GQW0pwqeN1QS31ge4KITeUwSENzJgroI67hI1Ww1hbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PZelK3atUxAuVkEgX/zWModRWgOJu/ljOG7F4LRTsmAYuXCiq5cPJMrZPrVce35DB
	 4UElVqxGrb2ARkV0SVBnO9GS2E2oLopMBfrzcCGbN2VaC4VPa8Puej2YI/xIHcj7gx
	 Kxem/ysAhzMRdElrDcYzdP3CTcKfBTGMQeZQYLQGd8F2J3KR1nlcPHIhtjgvCtHoaE
	 3q4eRIuFefnhhGWTVU7k/2JnNLAzdl+JOPEnBKA6+oPn8zgWxr5su/XH+xN117987V
	 pm93Qm5Um8H7wIIqN9OyC6oMwsEVV9BnbUzwhGVusUJWOm4Uogw7V/EQ4GXjpOL44m
	 vll46MSUgl1AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11C4E80BFF;
	Wed, 26 Aug 2026 05:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E9B71396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBD1C4054C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxMaROEjqXUn for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DGlvcS4Q
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39AAA4054B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:26 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43bf9548df4so719087fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722225; x=1788327025;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GQW0pwqeN1QS31ge4KITeUwSENzJgroI67hI1Ww1hbY=;
 b=DGlvcS4QW+MucLtr8vWR76fA+gAMb8wtWJP06FnjhkBpXPcRyBAk4V8jHTnEsZWtuY
 miblLvCCfm8sloMhVoaRl+3GLLazMAJenYrKdM6IuFFdmSIQfEb0iC4NrYrf/8Qmb+HL
 WkcWUz95+braFq+i17OUMoxb29xJpfMiXyaDRdevglOH5iRtTznwCh4GtOfD0ZCrO0cG
 QLw4BOfbMDX+JLJSMRAhCdLKW/beO4CkZztKNEnDTd0SxieMdK+GeiY5KTYSWW+qbiD5
 aCtpm84CvkG+RmhHJ+Yqr5gRzKkQJBhFQ8cDto7Vm6o+t3pPltf3VmjIhB97p3g7QiHS
 zD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722225; x=1788327025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GQW0pwqeN1QS31ge4KITeUwSENzJgroI67hI1Ww1hbY=;
 b=oH22bpEgbw+KwuJLSSOwDjyGJhyfnsbiSsx4x/nY4zJlRfWCBAH+nxxkcZQXssJLhW
 0iOBMMOaChfAqn7uDisgHx4WFynsvneq8gFGkUVWO6s5zBo8W/PEI/CH0/lP1Nhh62KX
 KDBu266Er0/BraSD02e0LMkwkFgrnaZ1RWO98bXaKuYy6kGaeAAPL3u27jHdrKR+DgRx
 Yqzx+GtuxtW0ZkVDxn1ucEYaLB9/DYj7+iRUTMyC8/unyDLGtg2mqPHQcBG8f03Uf2WY
 6mcDpIY9m+UXomOblexPjbUS9YtoOZkcuEqrMYAqNpdOHx7OOyH2Elto0eyEugd1JxxK
 b5hw==
X-Gm-Message-State: AFuF++kBxXAKaFykT1Eyrv4JGldiDSrZLnS3TW6AStLgUV4Lbj38Wrpf
 yWrBJacno9VaoKpO6w/lwcrM9PPhacuzckJAqQjZM2p7Pg3M9G1iJIiX
X-Gm-Gg: AR+sD11HoPfxbTQRqs5ZfnLlU6jNLRIPzhTfwpHk1FfMpyBD25b2qUa8p5zRdkD5fvz
 miiqC5BK4prFcS22SecYWNHCAj6P/hDzDkJB96aicSAKA9TEJM7UMkMWBDyX02uMAzQoZWydJaz
 W9OkmYQaLfOmxQZxok0GErYHxzKGP7JKFVO1pgbHz0mrBU2F12ZFNhro8jeGHx3LzTIf8M1fQMh
 e+PmZLNmhApHSXzKMoNhYebnG5K0kVzCilDcXFibWr4DcOGwN12twXUMvDqLhkVanUnOhlkU5TM
 RUC1/JhA9M2f71W5ePbVHgTrWAOU2ZUp8EgYJGDmirv9wLwkq4bCRv65l52swMLaZlXSBcnY0ZY
 pqkdTy0JIpdj3oikDPCS1yONf3Etgk6/uMh0JW7f+dPXX2JYYGG5qlu4G0a9vXGiOatYl6wXhZu
 f2SCqU8bqXH22na9qoq6QeeayzqofQCKq9S0xpudljolnXym7GC/sWKvTKINOBcr8VhX84ZEQL1
 L85K67fUTpctzb2fHett6Txa8+7q4KEsKiEe+ckJ26m2GrTp+COIBSwwIibDr8mbpiHXfhFk/in
 gdufviNOBG7F5kVfevLonVnwbDdSd2AZn0kogzi3odfLfAos0xc1dU/XzDszV729YvdpSPL0ZoX
 5G04HjHN+F3/Oqg==
X-Received: by 2002:a05:6820:a28d:10b0:6aa:1633:7af9 with SMTP id
 006d021491bc7-6b1a0541fc7mr3163388eaf.35.1787722225090; 
 Tue, 25 Aug 2026 22:30:25 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 23:29:43 -0600
Subject: [PATCH 04/10] net: netconsole: cache environment settings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-4-0892966aa758@gmail.com>
References: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
In-Reply-To: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

nc_refresh_settings_from_env() compares the current environment ID
with a cached value, but never updates the cache. It consequently
reparses the environment for every packet.

Build a complete settings value from the defaults whenever the
environment changes, publish it after successful parsing and record the
new ID. Keeping the defaults with the cached settings also avoids
resetting configured ports when another stdio stream starts.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/netconsole.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 305a6cf12c6..63b92e12bf4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -16,12 +16,18 @@
 #define CFG_NETCONSOLE_BUFFER_SIZE 512
 #endif
 
+#define NC_DEFAULT_PORT 6666
+
 static char input_buffer[CFG_NETCONSOLE_BUFFER_SIZE];
 static int input_size; /* char count in input buffer */
 static int input_offset; /* offset to valid chars in input buffer */
 static int input_recursion;
 static int output_recursion;
-struct nc_settings nc_settings;
+struct nc_settings nc_settings = {
+	.ip.s_addr = ~0,
+	.out_port = NC_DEFAULT_PORT,
+	.in_port = NC_DEFAULT_PORT,
+};
 
 bool nc_is_broadcast(struct in_addr ip)
 {
@@ -46,8 +52,13 @@ bool nc_is_broadcast(struct in_addr ip)
 
 int nc_refresh_settings_from_env(void)
 {
+	struct nc_settings settings = {
+		.ip.s_addr = ~0,
+		.out_port = NC_DEFAULT_PORT,
+		.in_port = NC_DEFAULT_PORT,
+	};
 	const char *p;
-	static int env_changed_id;
+	static int env_changed_id = -1;
 	int env_id = env_get_id();
 
 	/* update only when the environment has changed */
@@ -55,25 +66,25 @@ int nc_refresh_settings_from_env(void)
 		char *tmp = env_get("ncip");
 
 		if (tmp) {
-			nc_settings.ip = string_to_ip(tmp);
-			if (!nc_settings.ip.s_addr)
+			settings.ip = string_to_ip(tmp);
+			if (!settings.ip.s_addr)
 				return -1;	/* ncip is 0.0.0.0 */
 			p = strchr(tmp, ':');
 			if (p != NULL) {
-				nc_settings.out_port = dectoul(p + 1, NULL);
-				nc_settings.in_port = nc_settings.out_port;
+				settings.out_port = dectoul(p + 1, NULL);
+				settings.in_port = settings.out_port;
 			}
-		} else {
-			nc_settings.ip.s_addr = ~0;
 		}
 
 		p = env_get("ncoutport");
 		if (p != NULL)
-			nc_settings.out_port = dectoul(p, NULL);
+			settings.out_port = dectoul(p, NULL);
 		p = env_get("ncinport");
 		if (p != NULL)
-			nc_settings.in_port = dectoul(p, NULL);
+			settings.in_port = dectoul(p, NULL);
 
+		nc_settings = settings;
+		env_changed_id = env_id;
 		return 1;
 	}
 
@@ -130,9 +141,6 @@ int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 
 static int nc_stdio_start(struct stdio_dev *dev)
 {
-	nc_settings.out_port = 6666;
-	nc_settings.in_port = nc_settings.out_port;
-
 	return nc_transport_start();
 }
 

-- 
2.53.0

