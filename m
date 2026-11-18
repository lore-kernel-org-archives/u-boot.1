Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D839606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U6xG+GI1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wn6Nd3n2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28ECF40A44;
	Wed, 18 Nov 2026 17:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wjSo2oWffU0c; Wed, 18 Nov 2026 17:47:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A6EC40A2F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795024045;
	b=dfylA2PJ/zmz/f3vRxTsPZe5j43kvcMTUxyNMe/268sq6Vanb3isnesy04XEuOBGInJk
	 RitH+gCROS66vuRdj4YLhKmEDAPNWG/wT7QXVNZnKLTJgSOcL+6Xk+YSLWzoymk5+Elx+
	 48QjcvFtVHfOaBjo/rH6SB6qJxO7MJQDXCfnd3G9rqto7WQedGSwS/QP2iqST6weoStFZ
	 VFauUpE/L8YahHESoQJLVO46kDDV2hyQStmqcxxtAKPLoIg426frpstGAKu+v6anLOSLB
	 SM7Bdqf8CpIW7Bsj76qQh1lZ0F4GWcJX4TKxwKvU5ffi57L1cNYd3Hpp5j5OqvxZDiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795024045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t2RF61+eF5z7OYOH+AuQAlVwGXcrs0gijNqzc4D400w=;
	b=BYTCKS11RWMjgAkBGA7xKYBm2bm/XC4chb2bjbQBgfyo8Pd9+Ff47qQwjUhu464sfU89
	 uf1dQE7mKGbLm4D6+90uEyAbSLI5nQZjoois0o+q/iQ22YWdi+Rt4PyvT99K8R6o8zSyC
	 2KF0D2x7Mx190druVBMh1oe5Zqgyea4wWtGnAzWv+5IMq3RW795TsNLvCffRV20bSIPrt
	 34qEKLAGgsdIZJHK48rvJ4KhICapUz0Jpa4/ph12WZQEyQjz37yGCoXTWFEUPCubfXVfJ
	 T9EChHNL846TN2eT4TJONqWLiljvXZzqiL5j9LqcYJBtg6CiJUjro01ECwGOV4gdnHA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795024045;
	bh=t2RF61+eF5z7OYOH+AuQAlVwGXcrs0gijNqzc4D400w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U6xG+GI1/ohtCwYInws8HbKFqbWNMqT6aTIUpE9Eb/qLkMwb9q23I5EMFxIPAIRud
	 IETyZDF2wh+zkAAyANbN2qMWk45ZIuRfNAGkg//b7CYMeuqAvFso9vdICnIwZ5b0Pj
	 CS6Vm3vBXOJA17B8iCisqm2hPvMxojoAlCyo/3Ukh1beclVj/f9dk2AJv+Lxfpi/Zz
	 dSXXY8CAEQZ4J3U6qa4EoEqQkFFKQZixBmP6oIpiXIg/3CCOOfV/7C+idEP9L1LRBY
	 hpGT3sM0ul8zMAv11Qace8xMalX5c3i81EA5s5tBz3iu8bQsBAXD8SKp1dcDmeRHKh
	 t2TQ0n0gwZoJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A6EC40A2F;
	Wed, 18 Nov 2026 17:47:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C298E977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8B9F8125A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVcuafmnQ2JJ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:47:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 904998123C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=wn6Nd3n2
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 904998123C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:18 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so11832925e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795024037; x=1795628837;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t2RF61+eF5z7OYOH+AuQAlVwGXcrs0gijNqzc4D400w=;
 b=wn6Nd3n2uUFazQXaPKKuwSGQdFQTDvCSap6EuZQb7xPjzOQrRC4vfagHGPgG/RQM7i
 GKtsbBDlLOsZHpiTA4wkb2pxEnZAIyFWeREjkbkCRf7A6bS/hpBdSxlQd3EZn65ktmm3
 E1vc0+uQRoT8OzzPJ8Hng9/dBDyPhXMVs2D2sYyLa6nwaIEkI10s09lquBd7gO8V1sph
 loZhJAFGzBnbh8xC4IaP9Zk3gBKCUe3PptadDrxXRwr9JCGMlPmHFTxPW9cNnvxIqTX2
 F8B0lP/u2wHOB4j+sRz4engijQTp8HBQC/CHyJvb4iz57nOmig+iLJZJnsFI9EOAMbdU
 AXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024037; x=1795628837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t2RF61+eF5z7OYOH+AuQAlVwGXcrs0gijNqzc4D400w=;
 b=PjFzIEKajWwI8SR4FLJtk59peA0t+UF7Hyz5ukuuoin8q9yVmkEykrUHtGtjSWr784
 S1laH3F3io2WoHT+RxyepsDXdAmesHJSMk//qKdrZ8DO/L8BFTmAG+wapzs8bxpjBcwm
 m48AfM3x9MYqEmg4n4yIxKIVpQgqxCkTyiQHdL2Fj5qJAYKZreVHB8dEhAZnTQjPb7ZU
 iKpctJRcxGRbocCaDP9ikyDW7HCHOi+RvVYmzYzqNqVi3lk2SKmqDFoiYvRNxhK+9PIj
 LaitmtCJv9gZBuf2UWgeXParVrGzYdhjBs6eDZtPQnDcyMIE8opPHtb9UvG9yILooGyP
 XlIw==
X-Gm-Message-State: APuU4Z+TjSk5SOhnFeExJKmsSoAVbj3Nj7H2WRoRYYbDcl/yTiVaa9Zf
 V/9ZbNVtu+93OJbq/bLzfaLQOYTgyaR4jj1wmc23rKTXqDrO7eq5ay0j
X-Gm-Gg: AYBFou3rGEgRZIIz1KCUVtfV1nnyaFnHJLgoLy9BkcnChMhU6sW4gXLPDIrUBw2suWi
 dmmAlbseTw0Ho7djAmq5bOYkSKWRpkmhsGVX8pG7o8twAm9h3KoG4o5JfX/7GVW1+pgk2zs+SbJ
 kLbAIUlKXWEWBhiYqk8Rc9a186wPLDZuSBQ0mtsbMruPwFKp0JkQtE9OvBA5ry1wG3ynSfQR52R
 MBwdOrn7hbsM4JJx1/quBl5J/PhuLDM5q9XW1pJatdgy3E81sl3RtBkVBrtOALsHgV+31oiLEtj
 9cZdAgx/xBVBvURlModCM7FGnSgq4YCOkclJoufaccIXKglpeN5kQrDQbR8iBDMwQjiRkqK37S9
 9L7RN+NZefuqJU5qsmLaY/qhBfwCFpxG1oN1CluA9DB5ksrJnLaod6TcKmjiFIfeN6JljrkewmF
 QzhHsG5/NrBo2vC0lLOd3U5rLalzCz9HDwkyqN5TlqMCjKwbvBQtvInskO2vSmXxd1/AJ7sLC+T
 CWaEsqxu5Cn1zLpGWyBgZjZ9JhtmtAIH4QE0xBt8eI2Vi00ZFiIARIqXpEtdWHaoRuzq6t4b4lk
 CAb7EaKHVmjII+YknWW3D0FNcTkqSLGtXycHXzg7jw==
X-Received: by 2002:a05:600c:45d4:b0:4bb:5f45:c97f with SMTP id
 5b1f17b1804b1-4bb7da29ad4mr62459275e9.27.1795024036862; 
 Wed, 18 Nov 2026 09:47:16 -0800 (PST)
Received: from [127.0.1.1] ([151.51.238.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65683d5a2sm6302789f8f.43.2026.11.18.09.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:47:16 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 18 Nov 2026 18:46:59 +0100
Subject: [PATCH 3/4] CI: Dockerfile: Install ldr and clean instead of just
 build
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ldr3-v1-3-6ffe43aa8c6c@gmail.com>
References: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
In-Reply-To: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
To: u-boot@lists.u-boot-project.org, linux@analog.com
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clone the sources and build the ldr tool in /tmp/adi-adsp-ldr, then
install it and remove the /tmp/adi-adsp-ldr directory, as already done
for other tools, instead of cloning and building in /opt/adi-adsp-ldr
keeping all the sources and build outputs in the Docker image. This
also avoids the need to tweak the PATH environment variable.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 tools/docker/Dockerfile | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5434343b274..e666714f049 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -351,17 +351,15 @@ RUN wget -O - https://coreboot.org/releases/coreboot-25.03.tar.xz | tar -C /tmp
     rm -rf /tmp/coreboot-25.03
 
 # Build ldr tool for Analog Devices boards
-RUN git clone --depth=1 -b v1.0.2 https://github.com/analogdevicesinc/adsp-ldr.git /opt/adi-adsp-ldr && \
-	cd /opt/adi-adsp-ldr && \
+RUN git clone --depth=1 -b v1.0.2 https://github.com/analogdevicesinc/adsp-ldr.git /tmp/adi-adsp-ldr && \
+	cd /tmp/adi-adsp-ldr && \
 	python3 -m venv venv && \
 	. venv/bin/activate && \
 	pip install meson && \
 	meson setup build && \
-	cd build && \
-	meson compile && \
-	cd .. && \
-	deactivate
-ENV PATH="${PATH}:/opt/adi-adsp-ldr"
+	meson install -C build && \
+	deactivate && \
+	rm -rf /tmp/adi-adsp-ldr
 
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot

-- 
2.34.1

