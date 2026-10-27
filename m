Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF9606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gk+VuRFc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ANU1LeIq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 895C2406F9;
	Tue, 27 Oct 2026 08:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLzbSS711khr; Tue, 27 Oct 2026 08:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C7AF7406CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091570;
	b=m/wPrdIzdfQ6AMiatK3EIZywTgbsq6BvFJYkUgSGKWr/nyIVMgXGHD81I6J86FGasqmW
	 qanjRTnhzC7+oYj/pFIup4gBnpMks7iqz0gTHBmeIc5PQ/WvX+EuXK3oHSG6AbWTmMPsW
	 sk75JZnl8ssgGGXopYNTpoE9W0VCrlr0DXMLO05Dtu6RGqQuDoGnU1StAQCyrCelgivm2
	 cI6Qh2k/zNkUeutS/DP523R6rOk3bMeLXWD+6c9BjVNv/Gy1Q6OMSe6/VktSnV3KFXoWx
	 r7HGeCaIdHACFvdEV18xWzDxXg20E6PTi9Tg80JimAeK5Oaz7Q+hq6JLh3Of1yPK3RA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=stPeS5wRNgtwR/jeTMQv/le23Ubu8A4ph65JbBkJ7EI=;
	b=VGHcLMLyWaOaymIm83IIoGlH0jpFmlfsS06YAFPIJjcOeOYQb6nrEkQlLfiavNZP8xLk
	 Xc0WvFTpW4pZm5jNC4D3Ew5P2j7tuc3UMB5l3KBStFU8t6cOC/TrOBVTtKZd2uMCveRgG
	 hAzX+5GGWZ4emTbxFPYY5/TLddS8we2W+NtuZhN9KdkH2jtKiD6iiZOhygIY31Unp4IiO
	 /0RsHOGxg2XFD1jmDNQKABKt6zLto0DUv/7Cc+ZKAQjELr3hwoSv1/EGBLPGyZJbZGfxe
	 UVCO+tVJPGYHoXhHavEr+a5j6Pe/qjBCzmOFuhKcetnahFWcLaLiBWY3ETST74K4sRQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ANU1LeIq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091569;
	bh=stPeS5wRNgtwR/jeTMQv/le23Ubu8A4ph65JbBkJ7EI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gk+VuRFcxdoH3We8XUEcS6nV1qbph25woU2yG1ZEhNxkh+HHD+BrWacTF6Qg5nCaw
	 WvLM4p3hXhUBLSwv6puZ2AHFfB9vaia5Ln1t4RzRJizvjyjbLx1PEame5XS33TwNuD
	 uYWv3tqRQCHCZLOEHS3MvzhCu4ylzm7thXJ8lCjW6t5UjEDbOwKRMBlGelVVjrBihs
	 0IviOj17vKzXpQTPOhG3vOaR6QI/dHN0yVfQvLfI2SSzFZ53GUjhKkyQcXUbPiwEy+
	 RIxs85ylxdmunu3DPpNbcCN64DIMl/c/PuSzxNNGqTtr1Ma7sJDg14Jl997SYgF7RX
	 I4ewY5hiEsKAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7AF7406CD;
	Tue, 27 Oct 2026 08:59:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 71A24356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 557AC406F9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mvs-JKW3a9nR for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B8DF406C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091565;
 b=Ql1C6XwUSgZhHiZqIeeUBonq3MbxYZF9erDIsromiofx8uPQncxuSmkpJcwUyJhRM9ak
 rW7lpLoUfj9YAIj348A1NbqyqNOP1eGRc+d9RP3a8s5OrSuvcdf2RKqf1HPZ9DqiXOCvF
 hPOu27+0Hj8hLZDtujj7SHiEHC6hvXCCOqyfUniAXiU+Nxlnstbeqm54TEKvZDdgC5/Oo
 h8e1acSW4XXK3NwQzdTroA8FsmwHfthuffZ/SnCdASlh+kfQA94laJcUA3b21/TSIVXBg
 r1kgK4MGAKknEguI3ZW9xOXrI7mpCrwNQvfimSjWl6WWHsTmNrZUhyD60v7XNyKpXvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091565;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=stPeS5wRNgtwR/jeTMQv/le23Ubu8A4ph65JbBkJ7EI=;
 b=eRDN4WtCXDPbTfXOffyCBNQReip/lVN9Q6yOjWrLlWMToPMzjy1Gj1oz8475HfwE0xzp
 ZU9upc+ico8tCftyp5lJn+fAMoc13lCOa6cy0WMEidGTCfkif0EnzgDaUuvj/aC17tKKN
 NFkaZpXvntYdfFVDFCEw3sd6rnHAWUIgW3QWheu0IfmyWe13hBKw/eyTFvAf1mFF8ugkl
 fBcgdNYh3C8ypNIhDkkq1ahFyC6e5htidPVyzSMsL7IrPb77SbI8bi03A3vpwchyXryT/
 wwKjvuLXO8PPQcyzQ/7onP5IMidMT4pUrcAGqeXLWtJt1k3znKqNnjLgqyeb/r9+mAA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ANU1LeIq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ANU1LeIq
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B8DF406C5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:24 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so114150766b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091563; cv=none;
 d=google.com; s=arc-20260327;
 b=WVX6ydgJZP/ysCEYPnxsTlrVErRm0eE4zCNZNCGSDBqncyAgVO/XSq8DAmccpt2HNg
 u0ZETbcBfMM+EaAveiG+1YawNd8IqNHE3tyBbgR8PbakN+S0B3Th0F+fCNk5ZkC/JsTt
 xXt1ZkeRHdBHSpOh89kDVdQ9F6V+kmlcgTvqfzCBlFprzlMJBXodROQk08/tlYcBh6lO
 2oM+p0Y90RvcPHpMJOVX3xCv+A3VmoFOhR8Uuk0czRvYe43nvamD/ffWeZPZOXiQvqFo
 Wzzf28N6QmvnYpO9VF+wWd2/Ge5ma7Dn5d1tJqYTF1ze1EKSaCmKPK/LlC9R3uiZ54Xo
 RmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=stPeS5wRNgtwR/jeTMQv/le23Ubu8A4ph65JbBkJ7EI=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=gjORsBVaNohmyqnFARu7j50ELic6ErybkrQZYZ78MIkXknUtI3zAMmlTE1mFa9WQOw
 Rr0ybwYq83FUWm4xaPJXdykoHGDZ0gD6gLcVTGvtUrly0waHRVjJvruKBiua3wYnDZBo
 xiQTup7w1Aj4EYCNE73yCb/yjOnJR9KiUFAQMX5n0KooU7a8jtkM3yj/XDLhTpt4QTzi
 g8PBHJZe0K/2auWP89AHKO/7l92Oh9JivIKNwvvQ9+aW1XXjE8t+O6NEyDXINmjghLsO
 b9vosy2Gs/pRstY6zmnVNqkMIm/BKvZKFZTPo1kcZi2DCJcPNLWRux4R+IbI3UJsvvlv
 1Icw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091563; x=1793696363;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=stPeS5wRNgtwR/jeTMQv/le23Ubu8A4ph65JbBkJ7EI=;
 b=ANU1LeIq94yjMbS3Km2O2KwjlGlMlzU2RW7KiGsPu8G3OKsy6DMjnpzz61DZl//mBU
 bVlpNFr3b4ZA5lkZ0rObJtf7fhERPYBxriqTW1go4ea7aX+lb8hl+Gl/Mbq+p3Uhntjo
 bFajVPW7qJfyexYeciuzArHhQBqxN45KqwoGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091563; x=1793696363;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=stPeS5wRNgtwR/jeTMQv/le23Ubu8A4ph65JbBkJ7EI=;
 b=QCOzbKNNlcZaI/pbxiR5tCu9QMwDg9ePx3Fp5Vva7oWJdV/wb020fpHs4xg7u93O/h
 pO88dABGFvwUwNu/QXpuxY0DZxRNc3DcaOCsrkCYVANgMVM7ibtO83XO2MafpZVn8Xb4
 am/iyBWIYRznAPtj9O4oekqeZ9/J3C/g1FP/bFWh+T6MSOvPSETXrNUbPLF5GLuKwpN5
 8kC1SoVxh7V333FSY8ZZMY+omEG7cNpzUznyzZdIKXb2JQ74N0n2H+wqaeHUB0C6YEzC
 qL8TKK/f0/qmDbw7tVk7obPuEs5TMbKkR4jLjT01ZqbOR84mH4V2BR/PI7m7BJY9++pt
 9fPw==
X-Gm-Message-State: AFq9FYIaoG4EOPdEiwjdtyU/Hilz2geGyyeBbTrLumERc6yRWz4wJT+c
 bSJuF4oimSucE5nR+Arkp8gmsOPV0T9C+shsDIUtb7vQHP1GTG2dZEKRQC7N+Bn8GJKUN+2ce9N
 +HfiV8si2pu6gkPZO2I6hEANd76FtF5CHtmTuCL95oLaFXDL8MyBmnQ==
X-Gm-Gg: AYBFou3HMQ7tv8qLwhBrgrVP7dREqBWy3qj53k404jPZtk1Hyj9hIgi3FL3yvRTvVFJ
 txw4HiCXk3DtHzlEmYLJdscFOT4MaZu7Ehxs01OwCKXHLno+JrE6Zj4kOFxq3r7u7EjtQFCNb6Y
 SLFdgyfJRr96MCp5GDRqs7OG0ALiSGgVOqsAsn6dslRXlZStu8H1OYk+hlHCMJceqME1fI43zew
 CpXrshtqu7j2dnkQjuoZZ/6qpRyP2oTcQLuMA/kcS2A73Z2o/QxfQs6tbTLQ4vV3Auq3qsy/faf
 02p1e/OimVwbX/qVKzfkER1/30hYwNYZHDybL/X1Qdjq7TQ30vvqbQOunGq9XOi7WrdT8oDYMR1
 /yMWduGbUvkCbEbe8ML2k4u3YkO8aEZE1xJg=
X-Received: by 2002:a17:907:9494:b0:c46:9745:ac13 with SMTP id
 a640c23a62f3a-c49a7480d39mr141377066b.32.1793091562989; Tue, 27 Oct 2026
 01:59:22 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:20 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 00:14:33 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a4bf891c-985b-4828-8cbd-9fae1c8bf00c@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <a4bf891c-985b-4828-8cbd-9fae1c8bf00c@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:20 -0700
X-Gm-Features: AclHuK9fZTbeCtgtrGMPAm34xs2dckAWISkvLOey7mRmnqKcTSQ2HZo2xDCLI4w
Message-ID: <CAFLszTiwAyy3fmCOGSa_G8LZuT74iNE5wEXaHegYHfL2z+H9uA@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/9] scsi: Refuse a block size the block layer
 cannot use
To: anabobillo3@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:
> scsi: Refuse a block size the block layer cannot use
>
> scsi_detect_dev() takes the block size from the READ CAPACITY reply of
> the device as it is. do_scsi_scan_one() then hands it to
> blk_create_devicef() as an int, which drops the upper bits of the
> unsigned long, so the block layer may not even see the value the device
> reported.
>
> Check the block size where it is read, so that no block device is
> created for a disk reporting one that blk_valid_blksz() rejects.
>
> Add a test where the sandbox SCSI disk reports an unsupported block
> size.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  arch/sandbox/include/asm/test.h | 10 ++++++++++
>  drivers/scsi/sandbox_scsi.c     |  8 ++++++++
>  drivers/scsi/scsi.c             |  4 ++++
>  test/dm/scsi.c                  | 37 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 59 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
