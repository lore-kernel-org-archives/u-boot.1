Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C179C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E446F80BC0;
	Wed, 26 Aug 2026 05:30:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id by_BeUBJvoEg; Wed, 26 Aug 2026 05:30:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722231;
	bh=pjjgIwv4JDCpmWnG+Zstb/CqP097qj4rZjjTVs3qhaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hk6oEI21ASoHpjbzJVq0OxyzumJk3j4Y1cvM/Awx/ugL5qVtl1liTGMe01M8+PCkC
	 sgP/4jyyjsz9uBLJzxZeQlDnRe3QZ9lD2eFrpU6vR8hyEjJYz/CvWZz3d5CFut7WSK
	 eMYmAfZ8n/bMTxhwRaGNxIwx5RDq9bieamP0S/RSDUCq12RVY2y+qk9k28Sdz+JQQN
	 ASE/cgFAoo/fzhtm+0Vg8KygwE79zeM1233kCkDnxViS8Hma4sLfP6tQA4i8xUvjDE
	 SvwDOu5YIhqBjDo6n5HYSI85WSVBvwNUkfVBJ+5QAq/3RfscXGmn1uRmZBvjTlhMy1
	 83RJiets+ving==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD6F280BC4;
	Wed, 26 Aug 2026 05:30:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCCFE3C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEA48605F9
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2vOy4SXHVm2 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rOvOXgyA
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E82D605F7
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:24 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-448b69cfc6dso689452fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722224; x=1788327024;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjjgIwv4JDCpmWnG+Zstb/CqP097qj4rZjjTVs3qhaw=;
 b=rOvOXgyAOmL3AEPxx2b/EdEptfSW2WCUxwsokPQq8wDIoGfzoWxBLoRmYikNI1vB5q
 heIAHR5tr79rmKFCzHKQODf+njRD/8Jq++7vbaasK8CZmC/arQy37PCnLcim65+hctvv
 dc7PNCtSoIQEJAw+MAUrLUtJdt/SzuPQM+Z2UTgw4GjTCKUK+1ih5vg6k8LgGlgTz6ws
 tQz4h62r7wUpxkJbiig3gCLXqZGVLUBsF6o9lwB0/zNCkPElTmvjbpSn7P2r/3eSzWZw
 7uBLFvyqseEq9B9OvG8wvY1tfC8u2Yu87C4aWjE5Si0xpSpRLzaeorwFUbysleFp78oe
 VGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722224; x=1788327024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjjgIwv4JDCpmWnG+Zstb/CqP097qj4rZjjTVs3qhaw=;
 b=IUL3i1ZmFBgBxpM0P4oysfKyS9BgRvQ3B5syj39KaIb415LDnC68n46ncEfeh6Rmxd
 nj+CY8ibXI969tIZrBmEqYlMt0ZTVsUN8lugFO8bsCaLnKJde0FvPSG2xnNKQdSNWlHF
 6pa3e0VVMV4kVIWWbU0LVXlYW/ZZTVFUP7lNDMZkiH5lHZY6hfyMxBRwNesPjGCnz6yA
 uQQ1z9i4gz2sEbDFyHLvPASQMBSqm3ntHnumBfW6QNT9QuyHxqjyRQHFqW6DiYVo8FFs
 FntW+qVw6WTvqptoq5+bNtcsxndgoQa01TkvEQPm8GI0mpH3qxQtX/3QYQhIAlVs05TA
 +5fw==
X-Gm-Message-State: AFuF++kPm+uIZuzZEjD3Pcjs5323DAjr6rYDtSaoMYTED3A0OfPY2Pys
 SWFSaP9CgaRX+JIIRNzg6ezdv8Vl0u0NrPtErlgY2cG4rnK5oDiQJidj
X-Gm-Gg: AR+sD111yzq9bo7kkzoAUG6HQExN5nn5tyVdEY2eDHYQoIdkAMP7ilLlc42PDYNz/JU
 VZQgvL6RW3uwCCBpCEZakNshr40LS+f9pL55DkrEjYMwdALG4mBcT8enzZdKh5IDPAqn5mSgYJ5
 sNGvrIBbntSn9fG/rNZsyy2OZuuJ9AcGSdJtXs4ixsb8KaMp+qcNaD8xyQB2OyHhW8r65dutF9o
 AeW+a/XLY2aYj1sMtLaEfRhQ8ALjOfkSsRKmg6D+IBNg3zxe+moHq+8Rw6zefuwzZGn3EYWOEYx
 4j0BjkGN03ZnD47VliKQpWm39JkoO8zML5TcoC1oeylG3cAELDLK+CHweLmevGbEWlqfoIv1DXe
 pUmbZnn2Xq7/VSBq0hF7WOyF298A/AWpLHT8XQgiU9D8VD54gSDlzRfP4ut1VO0jEal11OJF77F
 Duuo/RuDHo9fl7UyQanqZu5Wv1cWZk8Zw2SqBrWGYVgsjeANpnwz9BPsp2FLsM5QcIq8D1ZpvZ9
 1/89pr3082b+wZMYBf368KxKx+MgJRgMA31vweKuIH4WnjNYBs3veb5L/hx+0KMhmPd9YxTj42x
 3rYs7isJ3J2rbNbfMYRMpkoR4caI15+57lg5ojFUM5pK/nIerpXr6ug70H/VmfPYueHYFdwozIO
 Q/QuPx2aIrnlyWg==
X-Received: by 2002:a05:6870:1d4:b0:456:b6b3:5b64 with SMTP id
 586e51a60fabf-46598c8ceb4mr4895195fac.1.1787722223736; 
 Tue, 25 Aug 2026 22:30:23 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 23:29:42 -0600
Subject: [PATCH 03/10] net: netconsole: use unsigned port numbers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-3-0892966aa758@gmail.com>
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

UDP ports use the full unsigned 16-bit range. Storing netconsole ports in
signed shorts makes values above 32767 negative and prevents them from
matching the unsigned destination port on receive.

Store both ports as u16.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/netconsole.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.h b/drivers/net/netconsole.h
index b2c3ecee6dd..11c2d1e0f48 100644
--- a/drivers/net/netconsole.h
+++ b/drivers/net/netconsole.h
@@ -8,8 +8,8 @@
 
 struct nc_settings {
 	struct in_addr ip;
-	short out_port;
-	short in_port;
+	u16 out_port;
+	u16 in_port;
 };
 
 extern struct nc_settings nc_settings;

-- 
2.53.0

