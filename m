Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fxdtgGQ1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RIzHzGR5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AF6F80E29;
	Mon, 23 Nov 2026 17:41:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 58Ke3WFmy5cS; Mon, 23 Nov 2026 17:41:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 741C480DE7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795455701;
	b=eixCaDldZxP1qYEG7wVUYFCX4tw5lFF9XJ214pkeganBuw1uM1SXQV0q1N3NNNP35Ked
	 rsQT+5hOEvn3IMkHnsdEHSajsU1y3zUjXptuQPF8xBmwJi+Mnd8JZ9ClI/m+99zugada1
	 TfEIH4Ixpo86mI/eaRHtBi4+26bXJaHTB4WxEhjE5dpeXOMBf8xDZoLxcdktLYUp3qzfw
	 TbVHLhdgq0cmH7tfKgo3R1Qt6aPkyx15cs5A/Y4kA9Un70MNga+2NW6fDYjLn+UmFtGyV
	 ceTgbFIQHNNbEfrI35LfgrHq/xSAzlN7gXgJZq92yYV2r0SCxCBinak458fgrtl3CXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795455701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ziF4dvW3a9Ib5kBOjhx5kmql1iQcF77Q1+Re26fZpOE=;
	b=SpZwwRz50hvarVqpWdy+Qgmp9joNV5Hitiqs29Eq+Yj3Wo2riIJfOqcoPIJtPxj1Xd5G
	 Dt3Acwx/pOGYOxFrXOkBqDi/Q1l3T/vnRdICxG9QIvaYEiy6tuD8IFWrk1TysqE1fcCsy
	 ZLMdZNiy15zIDX5x/WnVHREvrSmSovtGuq3xjUo0L2ofR+DtnH7InrAN7fY9MVIAuXPKj
	 KeD3SWEnTaWpYbYI4KeubDH52F/LBVgZdMLv8Oh683rX2lv9AOg//XF69j9DEpJJIygFq
	 kxecgKipHT4l+ZupXGgK14vRY1vtvUeosu5xA2LMiAX2mw7payhoU1poTMUCJtJrFlQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795455701;
	bh=ziF4dvW3a9Ib5kBOjhx5kmql1iQcF77Q1+Re26fZpOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fxdtgGQ1sultAJ67PaCdkwXOjApsdSXFmkh9gTIpvXRCIb5F+3VWCLM6g/kAsoIa3
	 VKi3nnHIHLUZNfpvnzTANR6E0hNy0vWP3Bx1hGD9opxYV7aFF8Egzz+oDaNWyvMSIq
	 EE3afLt9ZFSXwD0RIT0XhQ4580dJpHhm9BtNRaDx99pNij2TBFowObS/6Ru2miBYmA
	 Vjxf33AsQwJoyloVLVJkK7Vs2JUg01t91bhfkTJL1KsidPa/UF8btMtNKTKBEF77sK
	 48EJDrhuHzq+nPiXVnAcfnmCRIOk4S9QHVd+Sc7XswGHPDl5HOoRHHsD6Kn4cvuMJr
	 hUU2aZU5/KW5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 741C480DE7;
	Mon, 23 Nov 2026 17:41:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 45EB115D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 437D7406D8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:41:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KbZ7rERPJDXC for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:41:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 96D86406C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RIzHzGR5
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96D86406C8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:41:38 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-862aca1ed4dso1471337a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795455698; x=1796060498;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ziF4dvW3a9Ib5kBOjhx5kmql1iQcF77Q1+Re26fZpOE=;
 b=RIzHzGR5gkd3+xXUkhAYeNWErAuxKC+nOx7hCV/LyQAmJH7VNsadixGyC59eyKe4RY
 tR8WmRyeS/VCOdhV+yWxzfgzHcCCm1A4dRhv0CeZR8rVyFQhWTE6O9ogpKWvmQ5v6dPP
 NV19l9GDWSJfxIeZVddZt4rFpqf/6dEFgsI6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455698; x=1796060498;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ziF4dvW3a9Ib5kBOjhx5kmql1iQcF77Q1+Re26fZpOE=;
 b=M36XYb7eIJSnLmOX00jTAs8tLruC7BWuW+9sPxbUV1Dvl79P/jmIrznDUQSdFkDqo7
 7so677DVG74crYRwXgn317wQz6yOMP07wCNCObNOXZ5oo8e2if+iWgYzqo6/YHkH+0Q+
 ndy0AWjQg+31uQCCc8hD1qZMIbr+Uvza6pOmpv/0P2x2PYgm7xBfF1pFi3Eqj5VkOhWN
 I85NPVXvsSs4YpeW/zLujAR3xVCn1gtRbFxkhOvyNiBlV6yyXx+mZF7hYAs7axBU2TnB
 dwqTtr59pQuem2JNN9+yKqNCCDm2UK85DWUFT2kzTsFXcX/qmLG/kS94y2hAioJgxvll
 uiGg==
X-Gm-Message-State: APuU4Z+/Lry//0NKBUw+I3mPYbVfDVO/lAVATapMTtY4YjhfLL48Pz/7
 McRMqW0KkgB9snKRSoICee1pXVhS/P4zBs5/m26Tam8I/8fyDDjqwDU13S891X/Pq7k=
X-Gm-Gg: AZFdTZe7Bz+qI5LW8wBpQqMtDBCT60j1yYFcpaW8b/i4xcFzo2N5WaZgTQQI/nDyKIF
 IWNixdat4ssEe6UIwC2WURlRBBXQCSozEtBhbuArjIJkzp0RZZxmqGUCLLIlW6odRJ7bu7HL/Uc
 L0kdRisRS9QYbIt5TMwUH2zNzH1qiqtAUy4vVzgkPlSunh/QS3zQh+b/oWKIKXvr71ua+/hFgyF
 avSK2zrnKWgNpHWe5jv7x4cGUGwe500ZSsFwizh0SkOKWcPxXP6+bdN4Bc1GgZ+rMMG/+/cFYwD
 B+V1IVKtUV93g4WrQx6Ot4B0jAJ5i3bY7lc1hcgVfNjHzqo8bg9lGQQ7QEeSTfjgQAFqJhbO704
 vx93u/1mdZGoJKCert3Yhz6QmiDfCN3tYIFRCOIGZxwFND0PdEMe5IZKoVkmJpuWrkL1d9+H6cV
 fytvMIQ3qjRQHDniuzQcBEVyjfSsOwPCBPgSRWJznFBahp3AU6MWPxx/R30wvW06/bB7V3DG58M
 r90ZjZ4oWSNNH8ArEA6EnoSE6sgZp5etDVEIwZ+Gr/zIoIPE6snhY5jgBCFwErP+hmP8/vmtu85
 SEqZ6Il4x/WPmBUNmc532x2idbliF4YZxRBmFrAk/yhetG4ncmELLbYrduLHuR34ttBjJ8UqD8u
 yGOFhYc+BQn5QB9qzujDJh5YAXtdCOB0SxY4lpGMCiCY2sd0mKRDnLy0GhcfFOQ1MYuvkNFVeT3
 YNdH49IImtgi+WsAwzCMgYaTd6gqLgOA==
X-Received: by 2002:a05:6830:7183:b0:819:28cc:637f with SMTP id
 46e09a7af769-86314fe83a1mr12813257a34.0.1795455697804; 
 Mon, 23 Nov 2026 09:41:37 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168c1bc5sm8599626a34.6.2026.11.23.09.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:41:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261123151512.1870476-1-trini@konsulko.com>
References: <20261123151512.1870476-1-trini@konsulko.com>
Subject: Re: [PATCH] Revert "boot: pxe: support booting PE/COFF EFI
 applications"
Message-Id: <179545569689.3434707.5563138211763028549.b4-ty@b4>
Date: Mon, 23 Nov 2026 11:41:36 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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

On Mon, 23 Nov 2026 09:15:12 -0600, Tom Rini wrote:

> This reverts commit 841abbc6d5610b3f9572df5a53d770206a930bde.
> 
> There has been assorted discussions of the functional changes and some
> regressions this patch introduces, so remove it for now until it can be
> reworked.
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Revert "boot: pxe: support booting PE/COFF EFI applications"
      commit: 9391ec1c3f8c9c84a218bd08bb7cd931029deff4
-- 
Tom


