Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4399EC624D6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA258407A1;
	Tue,  1 Sep 2026 17:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4QUYefV3Yuly; Tue,  1 Sep 2026 17:09:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282591;
	bh=GQW0pwqeN1QS31ge4KITeUwSENzJgroI67hI1Ww1hbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=00Rw1Ue5TwzuMArBiFnan6YQ5Bgc/uBoIQWZNWV+VVGY+enYl0wUKtch8KrHZsKQI
	 vGLGpmISNjIfOhTF94onxfzXf2Z5Cuc2vu30uIRqYITgDzjlL64GtJUnTFNQpPnGdA
	 0kMmulqSw/nxO1lBUHxH61vOGDkfwsXOOvysW1cLMUS8W70PWEVM4maTmXoBc05yig
	 abdAaWvIl4RRByVjYAD2KbArCUGLa+qQH3T5vLmHeZD9mwcO3iGiR3MuPg4VHJY3AU
	 2kY7lt7xp9hHhpQ8UNtXyEvmeKcUSfbIhZfwbV9PTWZrtu5gLbobC78u/aHiMVxfjG
	 W3shbYYI0x5Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D555E40791;
	Tue,  1 Sep 2026 17:09:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AEC72FE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11765606F6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kwSCKW0SEGrD for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IdktXeQy
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FA4160633
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:44 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f4f3683fbcso91133a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282584; x=1788887384;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GQW0pwqeN1QS31ge4KITeUwSENzJgroI67hI1Ww1hbY=;
 b=IdktXeQyu9qb3dietw1H+g1Y0uUQXykftACrksWtvBJlrAhjYyBl48ELKSZ0Tpb0vf
 VgvF4Ow672ixboqwDnIWPtJql0ZLXiz4s/cDJywY4ZHaoWDtWznXbAKSub6+r0yS/10w
 IgsPxnujQUrrFiJrAsBTwsDlPkz4mnSKOhtTsvEEO0TeRJV/Oa6qIdIt3OJAHheCvvkl
 X99t8x8O07Dh5u1L2YseBex28KJYcj1dKio91FZsgujBr7AFfJtPS9zVWCUpL/511vxT
 5SAKGZtC63Vspw8IH5eMDfZmQXu2X1lGp4AHreQ2F7j+KWKIGY4VvPDdYz09rdIURMJT
 2Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282584; x=1788887384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GQW0pwqeN1QS31ge4KITeUwSENzJgroI67hI1Ww1hbY=;
 b=f0KEqHvoi2zSR7RpKbz7fIYNi1Y59DDXo5931ViqxVu0BFlsBDKfI4uxvNc8dPJAlH
 4Ln9igihhEJ3F+pd2wlNRoF4LmEKgSnAPe4WEo4yWWe+fwoRva89yLodmqo8sm0YKV3N
 VcU7G1IJ9+nkg4H0WQmvf6mHB1Nyy/A1HXIPuqjXrLuBOQh0j0sgqVCSH5LgPVoVPWDH
 9WhajJpLP9XqkS9HUvs0D6lrcL2f2KPBt12M0lyy9etr+/CVo4FkcKwsFvMZVxaYUvHR
 wbBqGAsh5hZYjmXFW/0md4ZrFjPTAAYPNBbAWECgeV0ipIWincjzclO7297OypfsBqCC
 8Mqw==
X-Gm-Message-State: AFuF++lZ6wrsctvwXWF2AyIyTKg6ROo5YvMB6JW6RYh06UXBC4LHlKLC
 kRk9U0DqW/uGfo0Ue0n89QFPd5CbM2P5gU87RXOUFPCPNFvSwwN8EE9i
X-Gm-Gg: AR+sD11flXWWn08dBfZ+Z+IV3GhpfuuVH/wiWn2ckXCJR5pQkmzBb/PHAE7fkKWkaI8
 p6FDZxW1qfx83IzSvqMRqKT0yq62lpVvSPf4gkY4XIIPIywjZIUbacUqH1TZAiFzFpZbhlHrRBL
 hAisu7eY8ND0fXaOuC+AIdbZV5cafQIfJRt+4St1zXXjnFaje1RpkL0pq4NlkoxqXDN41f0znp/
 /2fkzpy3wXaqfOh1IlG0Wfw4eqh/HVtle6Ncccu1DOHyD5FiGvpkDx4cuBLcHbzbNiT+MXR1HxI
 RA+r9+QXEmOgp7+JTP+/2SGMKnB3gue77JQVxStJs0Q+SrAPQoZ+SprSeUQ9CmlQW2BMV6Zdr1V
 b5lWA94Fo2Uop4wr9Jqv7VP5P9s7ZZRlnXZ3btl50S3eGrDrJ9KgcNJ1eEDJjdMzOviPCEIuix6
 +0ebwtUOC+6SK8lLYpjAOUkFIgABGiwmfomxW9fj9uR1I3oR3ZMUA2UZA1H6HlFnC5QIe0g5ZKM
 QwG9dEzD4Ag3DRn2QFDG8cacK0MkBQE7H2eY8pHXJAK7xiEEBQlIrNphSHPH92jHE32+xil8MAb
 +z8dR1EwAUdFY5onj001lufK/1NpOSDlTc/I8eeIuxaKdh3WMi2H6dylvVoeSs+7yMbC/72jc35
 Wi7KjpUFc15QY/Am1aNIX
X-Received: by 2002:a05:6830:84d4:20b0:7e9:f6b7:7752 with SMTP id
 46e09a7af769-7f68f7ad81cmr3868021a34.12.1788282583534; 
 Tue, 01 Sep 2026 10:09:43 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 01 Sep 2026 11:08:58 -0600
Subject: [PATCH v2 04/10] net: netconsole: cache environment settings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-4-3e3d95627cf9@gmail.com>
References: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
In-Reply-To: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
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

