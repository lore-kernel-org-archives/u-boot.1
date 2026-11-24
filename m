Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379B606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0X9udzA8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Mt6NBjeM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98D77607DE;
	Tue, 24 Nov 2026 18:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id apu5ru3AF0H6; Tue, 24 Nov 2026 18:42:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E58CD606F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795545752;
	b=ssDUZawKXkna4VsnsILjMUNi/gUpzASBi8XTIKMdzW2kgUf5Ea7Zvrlfv4TP3CE+Rnr0
	 bqiMI1h1aVPDrcpXRN3dhCtH9jtZJuWKjWc/dWNMjFEouJcEpUnulfKLlLmneUdT0BL/r
	 l65yfUvnjIfu+GIhekXUYREosH+VhCnUxF5VHUTMGzX054OM9MEiXR1bR6l8rQl+drbg0
	 QA0WcdJB5DdbNs3RkDpeJDgdk65+EhlalFXVx5w2rweFTzIWA1NrWBvs/tcOtSbYUGtJ+
	 6wtrLd49MChlfHX/HWMChyl1xkmzBG3kX5wcc9RQlof5DM42P6xOYHEXohrHHgzXAXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795545752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wgyKEYWhft4P4D1PosYziJ4ZJv7PWU1VbI5C/mIXPnM=;
	b=EU4Ihc0ajc64CZa30ubcztM6pJ5Mfau3LheQmwczzCDNBJfVzqhtfcjaIo7O679eebuJ
	 qVFgKEb7x2Q5xEDRoXZwLtHot4Af7fdvm7axp+Z5JN4EL2b2wPp187kYrstL6l3qRKrUo
	 Ta3/Defj/E7+uGvrY+OFDHrahGhmqZN4nfWu5WEhzKz6Wao/KzexOTcAI7nelRxZcFE2O
	 bBC3f5mjlOIpu2F/yu3/Er1NMK+7/YElplASZEhuZT53dnkQsQb8KxFvE8Ue8twerNTey
	 ddxBIARxpd7toWXDHcnZn8m5U4dtSavmCJ8ZYvJfy81jwwlPwoULia/swxIYux7jn1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Mt6NBjeM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795545752;
	bh=wgyKEYWhft4P4D1PosYziJ4ZJv7PWU1VbI5C/mIXPnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0X9udzA87CaTm1tVTONXKvzNHDpQeqHBmh13U9vM9A2u/wuKS2Gcgv84jMcm9zl3g
	 uGH4GBPbYlIuNGHPgm9o1xxYo+ILPd9raQl+Jk8Jcj/z+xLNgrrJbLF1aHS7qLr84y
	 BH8UpTyRk/RkYVCuVRC3VtGkjGp5JAerHnRkFgR3/s7DjZmoEbNeOJPwQ9g6XPnvwT
	 SjjQB1p82a5hy4T0n8SEDCyqCyPefX7PFgpzBames63Rme8GSAyqkT/+5b73gNdNXP
	 OMkX0paxGOgET4iVXKJhWpT0Y4sY4geL+KS9GrEVpZ59YEpd76WVhfoUor923bTrBN
	 3NXdIxMspRZ6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E58CD606F6;
	Tue, 24 Nov 2026 18:42:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D06210B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1343C60749
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8pZdUzNrBa1m for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:42:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D1E26065C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Mt6NBjeM
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D1E26065C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:27 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-5722bc8ddc5so1660658b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795545747; x=1796150547;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wgyKEYWhft4P4D1PosYziJ4ZJv7PWU1VbI5C/mIXPnM=;
 b=Mt6NBjeMbcORHIUiAiNlgao3PDgCwiZiScY0gFOeTXxweTlEhY1Qjs+XrHgSo9nOHl
 b2Llppylf5kfhZCgVDfPqol/XxM1CroC+Z8zsu44Ri5FOPdviEslFyOA0zVSH1jK768A
 2xXgeozmf+TDWkRcKMQVR+Z88ivThnJYQwe0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545747; x=1796150547;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wgyKEYWhft4P4D1PosYziJ4ZJv7PWU1VbI5C/mIXPnM=;
 b=Y+cJxMx5iLBa4IY5X6D/v7w+PJrLEddfqKxpRCXv1OaqySAZVionVmmc4KvuWJTFwN
 UiwElDT6NObf14a3Z9M7rTWE2pT5Fq6DaQNw98kEOD4xq2lTuA/Ppn5ACVmAIG9IZC0B
 Q2CNMchia5UCBk552ndl10iy5+OoA9JW1BN+Dy+FfYRzkKYwXoQbLQTcA1SdM+YlEv9z
 ajD4wLVV5fB9oCils52Sg8gyoLrunCHfeO7q64CUH+AbvTJLDvWirsuz1Ow9VR6+dje7
 utw0JJ45XdD7sPWQryXfn+Xn49v0ETZbqvUhah78eR3HVyHidFqdzO3VMPBT6vv/Tobr
 PYtQ==
X-Gm-Message-State: APuU4Z/4JRbglkRyUS9MMACDpOXG/vWF39LO1n7Y5ojYKr0u5abBjzwT
 aCWp6xvP5Fgf+1Abe5WgOmRTbbvIeaFTSO4aJaIpE7JmInA4Lgmiz5Xn/O8t830cE/nCdCPupOx
 ujL4Z9B5QPqyE
X-Gm-Gg: AZFdTZcjoFTkCFWPO8bTyNqE2rG7p0Hl/cJwQCTO/DJyreELZLRk0YVUx9F5B+/IFmm
 jOG5EhvalhB9q481oO6agFvD5tEqdOQ//8nhTamGCiMw8eNqLC4QchJHb/O0eEczTQCqAHqx5Fr
 7O1IyBKmVt0vDtZf8iS0xty0f2kFCYlqs1ZtlpRhf42as7naxCExT3SMTFmjQI0aDnh6d8OHZT0
 dmYQjgmjeM6nYrrmM+yabYuqYJRIqHJiwPaDu+cTlJ4b5w3tjg1Zft78KymPtuZcG9jtyWKwF84
 MdjROFbP6Yo1nXjC5rEgw3pKsG0fii9QxqXiQg9LkUuim56NPslRDdj2qyp/lkfI0yvC3RBA64g
 HAfKdNFzLuaku8raSxtzC7hWFY1FueURiYyJ531F4aQ0ydVnGfVvLU+iBkCiNjCJOi80Sg53gMK
 +VPV0HX8JE2nvjM3xBloeiGbDu9sadSCkqjaybAEV7ywLITpHNo1cl/O6A3OubgB6T5vZQDkLmF
 pmMQrBm3pnFmi11uQenIet5kjthfeha3sUMRGTAH3hjOajzb++Dc2mtdkt750wDTWzK6g/NKbYS
 vz/puS65T8iJFIdOwBcjnUIw8vwASX5cP2sQ8MWN9xnLPJPxNB57E00m+PjxfnXa9fsT45Y37Bg
 wZShOR5/KiGLq099HGFmgraocQlqQBQrh0omHso9uw8gRvhwzmbvWmQw8QAWbHnlsQhKLFgJ+Nr
 4xgb14GDL0gRRghbNbiwOLLdrfzDBofA==
X-Received: by 2002:a05:6808:c123:b0:4d6:90f3:74a3 with SMTP id
 5614622812f47-57a0c0a1267mr15401633b6e.46.1795545746757; 
 Tue, 24 Nov 2026 10:42:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250fa1sm11256626b6e.5.2026.11.24.10.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:42:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
In-Reply-To: <20261124155059.192295-1-marek.vasut+renesas@mailbox.org>
References: <20261124155059.192295-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm64: renesas: Disable DFU_SF on Renesas R-Car Gen3
 Salvator-X(S) and ULCB
Message-Id: <179554574572.1054544.2425898095429255225.b4-ty@konsulko.com>
Date: Tue, 24 Nov 2026 12:42:25 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 16:50:36 +0100, Marek Vasut wrote:

> The DFU_SF support is not necessary to operate DFU TFTP update into
> the HyperFlash. Disable DFU_SF support.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm64: renesas: Disable DFU_SF on Renesas R-Car Gen3 Salvator-X(S) and ULCB
      commit: f3b642def456ce44f1b783b3c852c67eb6e4685b
-- 
Tom


