Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7290606A337
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 03:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZqrCcKnW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lArXQdOL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E581F60DD9;
	Fri, 13 Nov 2026 03:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8nVDJv9kBKl4; Fri, 13 Nov 2026 03:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A4F660E46
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794539786;
	b=Y3YZxJu4vGknxIvm4JZwhoqJGUFsMDN8t4ccrW5xa/7ZcNlekkcyDfP11z8Jta9SKLrG
	 7PqQ2AmkB7Qmq7TcpvxQIO/S252sGGQVFYFJ9WV7cXz+dXo90q6+jYig6okNcJvwcyeGD
	 ayV6Y4kmH/nTCc9SGmn6jKAWnEVAOwQNYDAESqKDJYRrBsKSUwdhk9QHW23lPGaOylF6T
	 uo2hJ3nFU30AhVLojeEin5ivukvvqlKYvddQkq96JNAWcwkkALjAPFYNKAActBV/W3D5S
	 Jd7nJwdGCk8bJiLZ8xkHRgoP/4s+Ao0hSaxwikiUmADZwHXJq9uPc5uk3Bs6mnPBiEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794539786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DCGwLWfYlzlu9W9QIgWyZCarG742hCm/zjdpb8lWTz4=;
	b=s1zlHktiItAHafxdoXpP3yZxVqHvVrpffb9oAHM5vxAtfUP6gXxwCbky6nXxP54olWt+
	 frEBxs5z7Mc2n7S69JvuaEk6mwrRkTLmNU+Zcy8dffxUxB0d63Kt0ui1LPF9thhCyCt0W
	 OClFyTh3MqDDU9uukAQipZW1Fkvy6m82O+2U232NHguaLcD0sylxzB34ERWtymGFISZNf
	 p/N6cvTy21zf+LHgROpqKtFBQSgb6jPLXGvqgAAHo6+sMkhFwzPcjJP6e23YS3MNjnG54
	 hGZPOTG/j+JMI93Dxrx5RoUTGfiKlhyx5PlpTOX4rmwYTa5za2M2iaHy184N8INlL/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794539786;
	bh=DCGwLWfYlzlu9W9QIgWyZCarG742hCm/zjdpb8lWTz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqrCcKnWlfhYqkDsHr3A/llQzg7hNFhsLGdPitXq3hAICUepl/eV3WnVT6EtOJTc2
	 n2EIS81v3+jQpHJK4qgy/O+XlsrH4gLVW40IZRm6O1D1IO5YFIkV/E/l5OCBCoKWIy
	 zLr46EDTKoPx3aY6dC1QEs59WFxBaVxbWCJIaUkfF7iock9T/uU+frKDoSCyREUSaD
	 SFVj9ESSQSyTVpSzxvd8kVrs+dIHN+xZ1vfj/sCNfom+vPXy/keKkMzyv/VJiXZGTU
	 +j+T7J0m0lhadhStFdfvNMWENoXUcVE7kO8dpXReQCNDg0q0I4EZUXpOh3LJLZTH/g
	 y4Boo+gU8DP1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A4F660E46;
	Fri, 13 Nov 2026 03:16:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A6D0B2FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97BBD401BE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XIxMCd5ep11G for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 03:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EBF58400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=lArXQdOL
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com
 [IPv6:2607:f8b0:4864:20::132c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBF58400AE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:23 +0000 (UTC)
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-3791619605cso1135383eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 19:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794539782; x=1795144582;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DCGwLWfYlzlu9W9QIgWyZCarG742hCm/zjdpb8lWTz4=;
 b=lArXQdOLGlbSR19E8gnwXdYgLpyCZl09kectVUEKkJ9mGSEFxgtTE7U63UL7h5Hkfw
 FPHhZYMHx6qvKLF/mY0z1R5xtcbQMwkPF6hEtsJNGoYelAw1qMjPgcAUq0pMHvqMcvrD
 Wrp8ie9z3zNHI+59FEN6lOL9/3SXOQB8H9VFZs0u0FukM885cM2J/BgyLymY+b/Po2ZZ
 C6iBUr5LIB8FJ0iLJJmjiwevA+yV1wO8tt0OxZonnBvh6/xKzR9a8U/Xpf5wkenmQ2ty
 162Grkr40qbHUZAJVcNreDm/If4fb6Xb/L1+SNBJKttKKJZfziChvyifl5lEhRjrXmFs
 0CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794539782; x=1795144582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DCGwLWfYlzlu9W9QIgWyZCarG742hCm/zjdpb8lWTz4=;
 b=l2G9Q4lTIDYBIFgOTxdQb3MciyOV2++z8iv0424v3QPLObVyssZnCm15mjuwNe72z0
 JUtMil0FbvbWIUc/xqtmjqiMI1PXwfXT+kp5rQsh2B6JwdMyIjniz4qRjbbRnQHfJ/5Y
 v8pnXFSwjmXWg9vxugpnJicZ0hCWki1l4jjujn+4gDLDiZKGoZ1gwQ2Z87KncBjUNUf+
 hlTNwve2g5/4gXDGIu2wEmMYKCHVgQwB6UGDiq71FPXV+RGvWUHg9+nZqFOBbbDXWTSu
 psxT2psHWFzpqPThnulKg+1ZWm5ktDqkHVnFiWFvG5iymnzjuixlKNRG7OvxuyzRxfCm
 ySGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE/b5Tbx3bY3hq/s/ZAjnjtfn41aQlf2M9gZVs3LoMa9/5prUvn2bIFLDBa4S7sbtnjqPGeBLU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9CEu+DAgLxG3qStYtz6uUsOHodSB57nzVxZgQ1cJMMv1FZJHoJ
 IDjhSUsGMhvnxMTB50pzv+gKkxZRTD844Vo68AEZpC99KA8BMbjNtZDF
X-Gm-Gg: AYBFou2EZ2hlDvtJXatEpMsaZ4z/CXb92mDUa81g9Bk9Ml99fYvP9gb5JIQrMoIXfHp
 SY9EsWQ5Gfx6Ja/Rwm3WZwMZJtHCt8lR4rBFhlnx9jc8wKR4Hkxe0qN6FGiGi6gC1CxwgDqeMg2
 42uaxaHX09+D7ntYquyzif+ZmuNrFMuYGGqNLecApJlHCI1yHnxLLgXd1FUzmD5abo/imJ2Xqyi
 kuLGzwdUaMAZzJmt2Vq5XhaXxsiD7BrcFHna+rbMRZPj3RHsZTqXPFA64qNEE0uWA0L9srJr1GU
 rTT5dtAE0PLfOJ0SWpqT+AY3sZ85C2SDSFVlp40jjFtBV00BiX38I4BEctUUTC/wy+kLl3pRfkr
 q++Lr5HX21HKCuEXP8hjIoUmEYjhWJR7AQ86PO2w7MqARvMCn0TKYqWKncJzdJkmLlZqFUBz8GV
 NllIb5eK+V1auuq6c9+wv/6wyXxjBn3z0IG6YOp63bGOcn6dxD1GwFLn17/lfAhmTH4yzYQ7C1Z
 upip79KW46J7qrfg4amZLUK882ttM6EVwRi2UMyGv6TWjkOkUd7l/AQsBa7rId52HUcuWiCN7N8
 +mgf9lNhzIzmAwvc56oTdGgIeHSk4/NhqJnQOSI6ulx+g90fHzdrIp0iU4EkKHb2CEr2jxKrNtG
 gmIKBJKMO9aXiICNRp4pr9qWOl+Flo3+QPGYqrjBM69qBU9nWUTogWB18atfwbo8as0rJC6LNl2
 ZTnT95/wn6UIc5d9jgoFjMNBPLjqXlhg==
X-Received: by 2002:a05:7022:f109:b0:1b2:6b1f:1d89 with SMTP id
 a92af1059eb24-1b50312f585mr1100802c88.36.1794539782519; 
 Thu, 12 Nov 2026 19:16:22 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50313d990sm3864579c88.4.2026.11.12.19.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 19:16:22 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/2] configs: spacemit_k1: Enable onboard USB hub support
Date: Fri, 13 Nov 2026 11:16:13 +0800
Message-ID: <20261113031613.435429-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
References: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Milk-V Jupiter and the Banana Pi BPI-F3 need the VL817 hub to be
powered and taken out of reset before their USB ports work.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 configs/spacemit_k1_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index b8f777e89..31e429c03 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -117,4 +117,5 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_SPL_LIB_RATIONAL=y
-- 
2.56.1

