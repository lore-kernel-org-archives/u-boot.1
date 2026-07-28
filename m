Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995C7C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EAE560817;
	Tue, 28 Jul 2026 11:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDRU2WLHLgTq; Tue, 28 Jul 2026 11:36:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DF03607D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238569;
	bh=czPhLuJkSpMjg4I1tT1K1+0A2n5DQlBaOKXEM6uDLyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mJWA9W+b+t0LtxOHYNLwqCzcBumKoNsPWCfVwDM4hXDPdbtr9m99vgwroFYj2xh23
	 YbRDJMz7uu+Buu8wHibMKkdDil0+tHXdCRnc3kPEFaj5IDHKV6iXF3UpAQ1eF9t5Ok
	 IEqLo4ldzMxUAOHvk8z7bXb9S9NNIzuazZCN21Ee1BSkvj75+CsAfheDjTjoytJdY6
	 qFkqW4Yx1caWto982DeqrqgdldHVBIZHevVaUiph4oAlH6rsAk0hOU875gIBwUgg6f
	 vhCVfmihsoVEBMoBBREUwmezcscSBXSnQ8NCNGKO2kUeMiT6wbzJjanUdQkK8Cz4r5
	 +F1/ePgm1CfEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DF03607D0;
	Tue, 28 Jul 2026 11:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E095245B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D23A540840
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hu_cGckHPPU0 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:36:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sergio.prado@e-labworks.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5AAE940804
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AAE940804
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AAE940804
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B8B8494B; Tue, 28 Jul 2026 13:36:04 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52CC182991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:36:01 +0200 (CEST)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so2690274a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238560; x=1785843360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=czPhLuJkSpMjg4I1tT1K1+0A2n5DQlBaOKXEM6uDLyg=;
 b=OOO+8iTNSeAznpnyJf5qNjMp9ogeI+AgGtI8Cn1W8sxCt2h+EPGaSguT7gvAeBQ03W
 w55oGNVO2oj7n03sCSLC+ZOUI7jHM4tK1lI35iGVeIsaOofpQnhx8M2U7Bfszqpqsm2N
 qMdyepyYBzEBZQgvIs546m0fX/QGB3UVxoLGYUfE3Uh3TWfx69DpJrOVErzfAw46dBJz
 IrWarvnq6QvDE7tMxy5FZdVHdNb+nexKAVG55+sZXZjGnKekIoMhdsmPPd2NMG3kZZYq
 F8Lil/4quU0gMXfSupfm9y1dzBgttkaVloKd+v3b2o7HixE39oJYt0f8q/7v9a5kkxww
 U57Q==
X-Gm-Message-State: AOJu0YwR2vAx/ZX8rlZgvtnb/GKAstkx5EUQWI61WHC91nUiwweE7LxM
 M7ZW5NVmLHbT4gBB8PyDho1+7wayMBA4wbi5XJwvFzFKshenClRtCaYtLRcxMI7fePcJHBeFbpc
 QHJ39
X-Gm-Gg: AR+sD13K5AaIm3iy7hMdYEEN/R0E8qLdXbjmsjLBVEt+64vfE0YI7hxH3qoaLDmOf6Q
 J6TQ/BrHDCLb75cwMnq1EIdcrjuSho+PkQhwLTySPiWYdLJlWhWhWh/k/ItNGOiTFusVXTVHF1Q
 aCQgz9l7o9qE2+4dwbKL9TJX37YFF4rmRRZvhmPolqyz1BGa8y48ySnLB1TDjshfpxVysa6hcAJ
 R2towkgq/OU3IZJs+B3WdLu9vne/ECRjeYycONgXwgOGLAUBY9iqPqxJNaCZ//Rzf83apqo5/W3
 6VywLaXtV/XZ3tHvfhofVOVlG5apsBXWXEpKI3hCOSCRFUjgKiqg0oZrrrSvlf9qIns7ssMTZAk
 Kpb8b+jqZXWv8Ac1U+nctF1wxU0umd79991Ip4S2Ejrz3zkaTcIjB3OwozdWNf+KaBBWD+0uakN
 n4O1RG3IRuog==
X-Received: by 2002:a05:6a20:a11c:b0:3bf:5539:f93 with SMTP id
 adf61e73a8af0-3c8ba5c0303mr2577386637.38.1785238560076; 
 Tue, 28 Jul 2026 04:36:00 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:919d:7be6:2bc2:d3d3:8617])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm42603976eec.10.2026.07.28.04.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:35:59 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, sergio.prado@e-labworks.com,
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de,
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
Subject: [PATCH v6 1/5] binman: x509_cert: document Entry_x509_cert properties
Date: Tue, 28 Jul 2026 08:35:31 -0300
Message-Id: <20260728113535.128601-2-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728113535.128601-1-sergio.prado@e-labworks.com>
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1785238560; x=1785843360;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=czPhLuJkSpMjg4I1tT1K1+0A2n5DQlBaOKXEM6uDLyg=;
 b=Pc+9KFPKQEJtO6mRxUdHXyvk6S/wa0sxxf4GvKdk6BVngnCWHEhIvFby/p8iiy3kyx
 N0spn1TtGuMIvgtd69XaocIU0lMqx3YP5Nh3ZzodCoVwiqCqocg6J/Sdd4c9kFx1/KDn
 fJ0R6ElhdvO/CHjGG14U//B53pMHmphB/38SdJML9kSOacFP+1Iu3YChbjP72PBnSWjq
 KUUQwuDf6Ed06n3GDAzHnYHi25P1piimwKpgixrZceuUB2PAmZuXcT+QQPfBFnEHPNHi
 NoWrjPZFt1XzIC5Q6AARgFNyU/BWRydQKl250LF0w6c/70W6CJlVYQCZhrbWo2r5RUXL
 9gFQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=none
 smtp.mailfrom=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Pc+9KFPK
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=sergio.prado@e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.b="Pc+9KFPK"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Entry_x509_cert class only listed 'content' in its
'Properties / Entry arguments' section, even though 'keyfile',
'cert-ca', 'cert-revision-int' and 'sw-rev' are also read from the
entry node and passed through to openssl.

Expand the docstring so the binman documentation generated from it
matches the actual behavior of the entry.

No functional change.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/binman/etype/x509_cert.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb09..efa85f9553e7 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -18,7 +18,15 @@ class Entry_x509_cert(Entry_collection):
     """An entry which contains an X509 certificate
 
     Properties / Entry arguments:
-        - content: List of phandles to entries to sign
+        - content: List of phandles to entries to sign.
+        - keyfile: Filename of the PEM key file used to sign the binary.
+        - cert-ca: Common Name (CN) embedded in the certificate. Used when
+            generating a generic x509 certificate.
+        - cert-revision-int: Integer certificate revision number. Used when
+            generating a generic x509 certificate. Defaults to 0.
+        - sw-rev: Software revision number embedded in the certificate by
+            the sysfw/rom variants used by the TI K3 secure boot subclasses.
+            Defaults to 1.
 
     Output files:
         - input.<unique_name> - input file passed to openssl
-- 
2.34.1

