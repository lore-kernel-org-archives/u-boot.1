Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC8DC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0A5889D3;
	Tue, 16 Jul 2024 09:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RugOEHR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6E8889DB; Tue, 16 Jul 2024 09:04:51 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DEE5889D3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e02c4983bfaso5357916276.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113486; x=1721718286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6BHvXHOLWziQeAhPa6JSzlM1/VixhwvBpRayfpL5ykM=;
 b=RugOEHR8DhzUgPeHlZfQKnULcsx6LXTr1bT95dzvr1MEL2sCvh02dkcWXL5LpiBeEq
 wmGD/PlXJZgegOybTaKKqNiG0LTU6rCtQOY1ofTo8553vMoKUOCWu/0p1chQLDEdL1SH
 A4oGtHxwSamLtlC7V6XlG1XaoIFY8zHCsif9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113486; x=1721718286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6BHvXHOLWziQeAhPa6JSzlM1/VixhwvBpRayfpL5ykM=;
 b=gP1Lq/Ob0nDiR5htTAYB5+96ez7ccaascXj49vv24lHu0CQ6yQRSNFmvA5kT4bitoj
 C0fJtKpCiNor60Fuz/OZYDEmnti3BtKrUFS88ff1COH9yfpqxG5PiDfu4jZicqXDiqh3
 fDDKyU/5dH41G0UZi6kvOptOd/YdC4iTLsyfedfYRd74VoRkTU20b3NXFYtw3MrlOQfR
 Su4hw+PsYtn30JkSPv0Oxi6sRYSdAy93Dhm00bJNvk3KX9/O8QjJ4FRlR5V3ZO/iK5O0
 GrjT0PwNPhp5jg4KTfLpJrRxyj+Gh6/eT3qrp7yq9kCbhJH4V1dU+svmRIvvBrPDJ+F6
 A1oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURZT2084B23xR0yD6Vqmt3aViPq28SMmJIkbHXjnwguAGTgoxvXedYgVIGmKAWhqk/KSSoW+EqYOujfNQ1kl6nTT4FtA==
X-Gm-Message-State: AOJu0Yye1g4ZM9PqtENM3T7IK76hUaz1gSkfcVupZgttWy15+R66TNIe
 2rpbCDNtDjB+8ZJ+7zbCrmbXTUK/BBUUsXRNCpfDr+o8h/+Tv7dR/sBirW9JVvwoKB/NMZZH3b/
 eae57TlAIEtB/7WGPQQXp5ay9OxF30KZPVUvD
X-Google-Smtp-Source: AGHT+IHr25ih9s4b3hRrZ3niJc7RlSDBwHNIWCkFNDmz4gtxgjcQW0qwFMFOciD1CpPgU7O+96nQzN4oLhx2j5nMiQA=
X-Received: by 2002:a05:6902:1144:b0:e02:7d67:c5ce with SMTP id
 3f1490d57ef6-e05d56bd2eamr1723480276.22.1721113486213; Tue, 16 Jul 2024
 00:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
 <CAFLszTgz-SOFR+aV7f45+pfByLztAYU1kvFPZof665=QwjjoPQ@mail.gmail.com>
 <c1f036a4-a080-428f-84fd-c44f968d44bf@linaro.org>
In-Reply-To: <c1f036a4-a080-428f-84fd-c44f968d44bf@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:35 +0100
Message-ID: <CAFLszTj-1Pok7mJRGfR5fV20JMp5Hoe0r+4=p0S=NwtxQ0Gdgg@mail.gmail.com>
Subject: Re: [PATCH v6 06/24] soc: qcom: cmd-db: adjust probe for U-Boot
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Caleb,

On Mon, 15 Jul 2024 at 22:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 15/07/2024 13:39, Simon Glass wrote:
> > On Mon, 15 Jul 2024 at 11:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Integrate cmd-db into the U-Boot driver model.
> >>
> >> This is just a wrapper around an in-memory database, so we just need to
> >> get the address and validate that cmd-db is there.
> >>
> >> Since cmd_db_header will be stored in the .data section we can skip
> >> bind if it's already set.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >> To: Simon Glass <sjg@chromium.org>
> >> ---
> >>   drivers/soc/qcom/cmd-db.c | 72 +++++++++++++++--------------------------------
> >>   include/soc/qcom/cmd-db.h |  3 --
> >>   2 files changed, 23 insertions(+), 52 deletions(-)
> >>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Thanks
> >
> > BTW, this is a MISC driver. Does it implement the read() operation?
>
> No, the API (as defined in the header file) takes a string and returns a
> database entry. cmd-db users don't have an easily available handle to
> the node / udevice regardless.

OK. The closest thing might be UCLASS_SYSINFO, but it is designed for
inside U-Boot and uses an int instead of a string for lookup.

Could you use the devicetree for this information? What sort of info is it?

Regards,
Simon
