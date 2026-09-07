Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF3CC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 21:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDEA8606AF;
	Mon,  7 Sep 2026 21:22:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGgQ8a6E3z_j; Mon,  7 Sep 2026 21:22:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 860D760662
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788816125;
	b=iTFZgInhbx8CW9+hqJhSfG9dj/IjsG9nFXugIXpSx07RUcYQ207YdXuUHtzwvUqsZi1I
	 /TTQknzyGtiEFoFV0DDLTxmAdwrgBqK+tI1mNjWZYUYgnRXDbK0YekD8Kh+kNxWghxiFH
	 NbDwvyDbngm2GUn3qOx24NTKxJ91HaQJulzoLG0TN/izB9u5uFZtRROSo1E/ms1km32Ya
	 QVru5cFoWYK2/g8XlOe4LDl3VNYo3fQOXM+TaeMguihJyEqWI5xoWEKaBM6cSzImhuW2o
	 LwBcoByqFR84Wp98W7bNsQ3wOidLuPJYb8ssTwjZTFsyIoKE5Ph03BZyQgFZDPQwK0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788816125;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eOsYOi3+aSlzY0FOxeCqq7jWHfjR831Z8CB/oGrto0w=;
	b=i5rtzTydsg4kDAmkcs7zoe7retrSd+q4Di8XC6HIxLEmblp47WGRZx6StREykD/cSQMe
	 0xfvgA0sdjZXfXrSRY81nUsSbcnt5V0UmiHnCaGIr42DJByY+u3+xp6Ow8sBTPG3BEYyp
	 HogECEpomDL5pE5lJsapuaMI8cw4K82MHm6mOtAEPtK10krdsPuIdQVF2OrmM8BWgWEU5
	 FHBAAdzj4Xr9fxbrtWybfyAny66upByHhVJSno0z2eUaT2oyCPG3mYCjYAeKmJkJnXOBx
	 HbHwrG7fhLy/orlxEh8mIgQehsvQUxgvIrkx3sYrfflRLzQ6JJUHBDXK7w5emeUsqsg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788816125;
	bh=eOsYOi3+aSlzY0FOxeCqq7jWHfjR831Z8CB/oGrto0w=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBGKZ1j1S59Ofc603bRAUtlINV9zAaH1IFr68BLP2cPC/W8yYq0Bp4iouxkDoR7I4
	 VaawmZ4hDAK8qpXGqjMwGlna0JOeQPsuNCZD3anfbl1wMU74+PNhhqwt/Heinc5G1M
	 8wSkD43PPYcYAgDryazcMhmrp20ISd0qxPyRYrC/cD8qwbgintXDtiCXm3Rkgk0SJB
	 CciuQhWErIhHJPuOhKHSPnBJbrxixIHqcISM0zdL2nuEq2yJX8WRhk9W4ieMy6bT5Y
	 mn4CTSEZbcqkimzyO8N5gu82Xh1PhEFIbiLEKEKMcEmZ3PKIMEV+HWS7JYJ0xzLc73
	 fp9hbg/haWieg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 860D760662;
	Mon,  7 Sep 2026 21:22:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3801149D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A00E40099
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAQcXhii-Ejc for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 21:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EA83F4005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.168
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788816121;
 b=XyRw7vMAk+YqfM9eqB9GusAVfk0G9EBUsgJ4HpXVqypsJbnLy20nL02nt3tFEu9NnPTp
 BOwcwauIYmiSsYG65k+mAWPSG92SeV81wu1A4ufejfwuNtomczrsGWd9ktX9P/cEXTag5
 c7GWNfMmMhbcdpIMoQnYFc4DguPAJ1VRKxag33MAWWTOh2UzqMGFE8+1gLFbMhooxpYkq
 2FWCsBjwAuCsqJkw0r7OMTZluD2Ro8bxsb9UYfxu4VWyjhd6Y4vtcVPJKRvQ8+0ZhUZ+Q
 UUF7zwcCfeAOJNYvPilOg4k97a0lcF9abuu7++KD8ptNxqKSzK608ioBSeDTTjDkz2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788816121;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=eOsYOi3+aSlzY0FOxeCqq7jWHfjR831Z8CB/oGrto0w=;
 b=nE7sDT8ZNEcL1jgl4hEIsYAx2qKb2K8Ius7jH2imDYiH+TcRftxGDfcEhyXzjnxxDbkN
 xTLnNhxBaIwMlHNtNwvztuhfbKhi/fAPoyu5yar03YLvtf0vxlUVBd/WPqIhhLKNXtTSF
 M2ERrWfU7uyLRQP6Vg8qkWnCFdCOR1b7jUEHuMUo/l9155kfel/0u7RnRwrMfsO+aKJQA
 pYjLtKQmloEEjfxAdEnWJ7RsGmwdHlV7T6YLcgXkV4QQ0DXJjSNZ8TxRkIxB8aw9fYZKB
 T+rw7h9ue651fVCRmSWo7egtUCbTTLGX1X0zcJfOPPFcOrSdrpX8loBEtwRXXi6Xusw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=xs4all.nl; 
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=WyYiGwcE; 
 arc=none smtp.remote-ip=195.121.94.168
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.168;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=WyYiGwcE
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA83F4005A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:22:00 +0000 (UTC)
X-KPN-MessageId: 277d77f9-ab02-11f1-861e-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 277d77f9-ab02-11f1-861e-005056aba152;
 Mon, 07 Sep 2026 23:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=eOsYOi3+aSlzY0FOxeCqq7jWHfjR831Z8CB/oGrto0w=;
 b=WyYiGwcEk4Sn2gHgjjE+ZYA8uprptCVqnI9DLBe4H9WcrYc3aEaf/9/uCWtTXTi+pbcAkyPxtUjt/
 LEeI9dkca7XZUKxyF2kY+qRqsozyz0y/3xED2imvnOmdeKFj3q4tOJM5FmKQ+0xWD/tGA78gaC6r4F
 xfQXljduf0b+BZtjsTULFN1860ggWluLhOtqtULku7VMdFwueJs501zmzI+K4IvI67lSlIGIBXd8q9
 F1c+EtR1CBQRjwR6r1xegAeucL5SVHhnOo6PZSouPG2EYIyBe1rZxH2PVSr6tn6p+toe7RSEBJ+T32
 jd0xzrx0Rn+e3QMICWBN/sDvJrtGjvw==
X-KPN-MID: 33|gja5xEZxciysXLvWI5GcSNIEn1Ns/HXOJoPqJ3T6AvjMxLQwNMwIxqwJuuCoqXd
 3E2g8uTWZK+8BuPXQNBkwRstEeQ6HsW6SPYJfnX23M5A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|VGsV4M5FEVOXPmImpMVYhy04k8bCkoHeaY9fqmlthOgGhyisItXEC18Fq1dk8uG
 jMM4g6YwuLcZ5pWgeM83lQA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 26f9491d-ab02-11f1-9281-005056ab1411;
 Mon, 07 Sep 2026 23:21:56 +0200 (CEST)
Date: Mon, 07 Sep 2026 23:21:55 +0200
Message-Id: <87se3ksqoc.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, asahi@lists.linux.dev,
 kettenis@openbsd.org, sven@kernel.org,
 neil.armstrong@linaro.org, bmeng.cn@gmail.com,
 trini@konsulko.com, fberder@outlook.fr, j@jannau.net
In-Reply-To: <20260904-apple-nvme-fwabi-v1-2-f7ede661c469@jannau.net> (message
 from Janne Grunau on Fri, 04 Sep 2026 21:22:40 +0200)
Subject: Re: [PATCH 2/4] nvme: apple: Never set the opcode in the NVMMU TCB
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
 <20260904-apple-nvme-fwabi-v1-2-f7ede661c469@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Fri, 04 Sep 2026 21:22:40 +0200
> 
> macOS always sets this to zero and the firmware starting with macOS 15
> has started to complain about what we're doing here.
> 
> Based on Linux kernel commit cc0fec9b42cf ("nvme-apple: Never set the
> opcode in the NVMMU TCB").

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-3-bde19ce8db04@kernel.org/
> Fixes: 50333c94f2de ("nvme: apple: Add driver for Apple NVMe storage controller")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/nvme/nvme_apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
> index dc94988e2ff..f615f8fac4a 100644
> --- a/drivers/nvme/nvme_apple.c
> +++ b/drivers/nvme/nvme_apple.c
> @@ -121,7 +121,7 @@ static void apple_nvme_submit_cmd(struct nvme_queue *nvmeq,
>  
>  	tcb = ((void *)priv->tcbs[nvmeq->qid]) + tail * ANS_NVMMU_TCB_PITCH;
>  	memset(tcb, 0, sizeof(*tcb));
> -	tcb->opcode = cmd->common.opcode;
> +	tcb->opcode = 0;
>  	if (cmd->common.prp1)
>  		tcb->flags = ANS_NVMMU_TCB_WRITE | ANS_NVMMU_TCB_READ;
>  	else
> 
> -- 
> 2.55.0
> 
> 
