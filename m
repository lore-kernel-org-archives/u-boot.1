Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B5606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PJMEz4Wa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFp5K75z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77C1B80DDD;
	Wed, 21 Oct 2026 09:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xg8mgS98j60f; Wed, 21 Oct 2026 09:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B4A4880DF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792573507;
	b=HsibpeVtRez5aU+sMjoAA/hkXxRPfu4UYP62G5SX5D+lv06xSD5KvHsDxwLL9P6kUmvO
	 GlFz7CixMVjFbAS1UfnF+46t5F8CTp3YonhNMcxaYSZI46Hd1DDK1VKCzbbWXVxwd1Ery
	 c8Ibr9hlv72nBs/wNWufToQgMaQbhsN4tW+ufvBolXLVcrgLNb+rdWXOSrZRwiphjSnAV
	 JsvYIMwxmQNV0hBFlk8TEzZmXdUsVqzRspDsXB3ND/1tTCazaXlg7LqAH6lku+w7i+BXc
	 zUNIS3Rxq332xbeg/Tesnt2Pz37ZP+6sQ9jsWTCz+A+PQUdcq002JFtL96I0BKrqd1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792573507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+I6bY7afuz4Pjshb80Wa0BuUR9eLPCOwSWs5uB11ynk=;
	b=ZJx9Pdp/6is2JYpucwW0kI6OAGa3a4eMW9jM7cB7SHS0inyaqdFztVp5ErNaQlXTboWe
	 FtQJUWAJNr9RVWN4KSTIqdGt5x3d6TyiQ2dr5kr/iMwXfsKm/gPdjzJx4aNb0mcqvTu3o
	 cZwOwWnljzq3LyczRDNwAQ87s7bjiE7T1BHRbptggRrwXTgkWy5WgwnOpQIyZZ4W7cPxX
	 L+T9rwU7cQSjc+TQf/oJOssaCc0UBF6ATtSwM7t52lfvCwBwc9Qlc4R6IZTWGEFL3XEfX
	 w9/uybiVHsfyQvMGOhhZtS2yxHuBUjLjGWiALmJDGumX20LiyBusnFvMLCM4pI2wQwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792573507;
	bh=+I6bY7afuz4Pjshb80Wa0BuUR9eLPCOwSWs5uB11ynk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PJMEz4WaaunnVJv+mWmZnxOX3Td+zXRLT/Ni7WueCtx67+eQc3HBbFgKuNyBGq3La
	 vD10nbQEhNCWET91ROSDFbwU47qIgCrZqJUg5IkmsU6tvx8Ro0+c2/NMPuNouw+BrC
	 RzHjtPPKarqJAYCZM2XSsiSLcolfrQdNXNxM0Vkl6cJgAURWRAkW3a+TwXhDV97klG
	 2tDiZEDSfBJm8pzhCCOEniCKGgViXsrvjvfIhaj1cAbMvpWePPdRqsgfbIFv+o95TJ
	 pHFiLRhcXymuSJTK7inaOqeU2cCO/+fwCuNWHhjX8InQSmPbxB9tijKdaEcHi8/GLk
	 Bfav+T1fi1dKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4A4880DF0;
	Wed, 21 Oct 2026 09:05:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD1433AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDAB540050
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t3uqrSMAhj4r for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2120940060
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792573506;
 b=nWGgs4CjeRMmHtpni/hz80eSNzZfFUnm22VYrGPwd7VNdocBBcaW8b1/9GCzpU7CC+fb
 a3NVC/pyid+ER9wXx4oWQtbG6Fk5/Fyu/sdUUFvFV6buYUzADXjZGvTd55ttFoD/Kwe5y
 CLAVG5GdHaj0OvzUDMCe1mTzuKYmpwewmz+CDoyWdZx6Cy+JAvKmoVE/Wz5ZeGKMd1+Or
 e6B70TxOj7QQG6V9Nlv30xZ7QGfcTrQ2x3d9u8f7ENTO7NNLK1AoWtN/TAoCSOkO66K65
 8F4S5qgqxJHs7elTcwtCqKuLiQmjv+AvUkGIRWDwfUV+vSb0rpeNb+THYA03IuKlR1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792573506;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=+I6bY7afuz4Pjshb80Wa0BuUR9eLPCOwSWs5uB11ynk=;
 b=f8NdF0r230yQ8z3w9QbVkBs9nRCANk9EctrP0IM6mcEIid+Ug2F1M3VUuBDKmikinSAH
 CczAcO8x/84guBP0k2vxw/U7cMe+5Am7IG31svI2P+lPCqzk0cDw/qPzHlcRv8NmDwmKc
 Fp9+G1dm+d7Vc307FqUOAAeg2w3oIp+HkQp0nTTv9DRO73cMYgwcoluvLqiLKAf99dL9o
 CgaVfCwKiSuUZ4zH6koUtDF+p/KG9SGfcHEMJ92+ixP5PNMCMyZbrRBaXJnGMIvwYH4gN
 OSBnQzsCwflCnkoman+ocp/dGzpDUNVdhWyENnD46LW/EjTjAOSCITcNgaudOXytBaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nFp5K75z; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nFp5K75z
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2120940060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B950F40C1B;
 Wed, 21 Oct 2026 09:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291231F000C9;
 Wed, 21 Oct 2026 09:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792573504;
 bh=+I6bY7afuz4Pjshb80Wa0BuUR9eLPCOwSWs5uB11ynk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=nFp5K75zep+OgyNl1OHiwEqywXVbxI6j66fC+S5uR/qzI71a007Y4O2A0capwbo0y
 mZoNCtm+bqvzYVmRBp5WChAGGgbTHXEsMjiHIF924Gt+KEDXUXhxt+IDod+0gzj7bf
 YMnZMlbcQMaAZvfDo7VjzSv+5W//Eb75BEj/9/XwaIEvX9cKSSy3vShtpAdh35kwsY
 efVhknl5NbhzTHZ6cPPh7GkAaPrA/ADPXnmU8H/20t5DOo1ygQJNsMWMpx+R7Ec10O
 ivXfso5L+Exp/sdo4eNLGy6Irz0BYVpU5KIMlkgD3uPhyWSUGaSHTUwpY6Nt3u7dTa
 p2fg+8wB/02Ew==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jan Kehren <jan.kehren@emteria.com>, sjg@chromium.org
Cc: igor.opaniuk@oss.qualcomm.com, glaroque@baylibre.com,
 trini@konsulko.com, u-boot@lists.u-boot-project.org, Jan Kehren
 <jan.kehren@emteria.com>
Subject: Re: [PATCH v3 3/3] avb: Take a storage interface in the AVB operations
In-Reply-To: <20261021074345.1282758-1-jan.kehren@emteria.com>
References: <CAFLszTiRKgzf8kqS4dWxj5SWGp78j4eMiX5Q3dTKS4MT=CKx3A@mail.gmail.com>
 <20261021074345.1282758-1-jan.kehren@emteria.com>
Date: Wed, 21 Oct 2026 11:05:02 +0200
Message-ID: <xhkdbjynbpgox.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon, Jan,

On Wed, Oct 21, 2026 at 09:43, Jan Kehren <jan.kehren@emteria.com> wrote:

> Hi Simon,
>
> Thanks for the review.
>
>> As written, a board maintainer can't act on this.
>
> Igor's "optee: do not announce RPMB from within a supplicant RPC" should
> fix this. It is still at v3 on the list, so there is no commit to point
> at yet. I would like to send a follow-up once it lands, naming it and
> adding the "mmc dev" hint you suggest.
>
>> A follow-up could guard the mmc path with IS_ENABLED(CONFIG_MMC) and
>> drop the dependency.
>
> Good point, and happy to take that on too: avb_init_mmc() calls
> find_mmc_device() unconditionally, so it needs the guards plus a broader
> build check.
>
> With both heading for follow-ups I would rather not respin, if that sounds
> reasonable. The series has Reviewed-by throughout and Igor is rebasing on
> top, so a v4 would mostly cost him time. Mattijs, if you are happy with
> that, v3 should be ready to go and I can provide a follow-up afterwards.

I like Simon's suggestions but I'm happy with taking v3 and taking
follow-up patches.

Thanks for the great work everyone
Mattijs.

>
> (It did reach patchwork as 2322465, not sure why it didn't show up in
> the first place)
>
> Thanks,
> Jan
