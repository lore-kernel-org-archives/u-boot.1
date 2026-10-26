Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EB606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=des5LZKO;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MffpnI/c
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C38656072F;
	Mon, 26 Oct 2026 11:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_OfgDcIpb7L; Mon, 26 Oct 2026 11:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0BC9660726
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793012568;
	b=IREiaLFbIRX36Re49jowdmKMwRy2wH9M5KMxWlfCrpFNc5B4tvGvQDk2BEKYAWWqsYKo
	 Bl5HcuLk9Sm1txh6lRxwYAfgcU0ILGl8CjQnzlL/9tAp9NvX0wHze11dh29PfpnJQ9a/+
	 RwjXlVtBqUPQLKLnZGWkTFM4ijh5v1QuqHBGcPt6IXbbob9IA7gRpwMMtAtxGVmpo8osT
	 OxylGiukfykAmS2Abji7tzuQxYjqRKQNEAGuhQLcEQXGjugkKpljiUYcFN7lpDDx4omMy
	 vs33NzrcsfGrhvMzsRShDSJQmjg2nhjOmDixXKbrTP2JwyOnf3BHfSPflhqnXBnXF1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793012568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4tOvNesHGOFOrWnb449cHgRTZABmrw6U/93Rtk+jPfs=;
	b=jyXMHGu5G1C4AgJQ71ZN/wiqty4kTiNJ7uOpg3A3hFjTZLgp+RRV2qOHazHfDwSF2rAo
	 Lj/70eDy2+sZ8ck0/jaKil8U1gn3y9wzHlBgm0QymwpfLuBoyytMdEuklD1uBlY3onUuN
	 hjElo5hEBhZwXlBjRdcrm2JG+ZBfEcqplnNyNlx8wuvQbyBfIoooHtUhAtmZXJOtxTzQ7
	 2zVnlQqA1wYj+UF6OBZ4lH3mfmS5HJB7ZwJcfVhRdHQuwWNxhHtzVK35L5j5i9k/iuAap
	 MeqotTg914LorAezjCh5UwLUordOjFF/Ii64acofdMNzCxsSF3EDraemOACqJsYp7+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793012568;
	bh=4tOvNesHGOFOrWnb449cHgRTZABmrw6U/93Rtk+jPfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=des5LZKOqVaHnKKKUjhiVAYfdlYBmGpwyTnOWV8CsnA07/4nu9bWCo2/bFv0HkRms
	 YCZIFGiz/HIz5PXUFmqrzoZseKVoXEK4g/H43qppJktdz7oZF6PQf6HEBwd6R1q7R0
	 qqnBwSDmsnqLbrVl+MYEFUEos+ZBYqyY1WzJV97WdD7Xl7zkTPOq0tHEoRLOozfpx4
	 KycLoi+jz1iDkppNdFI47tQa6C0M9ubzr94ulRyB7yKXiQXlc4yL+Zm5Zif+7vdDoK
	 +y5gVNxx3AHUrKuZyUbu4bNQHJYay+1ithcuxJYbQNhVvZNvB4gYeJFd9rtcKFXcuM
	 c5frBQVmGlIvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BC9660726;
	Mon, 26 Oct 2026 11:02:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 848FF43
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8231F400F8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYmAJagCSGXM for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 11:02:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6D99840072
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793012565;
 b=MbBpw/I+qEm5/ohJsatLCldr89J407bYTElmb+mn6cwcvbJg9KaCbpsbTPu5noZLlPq2
 k9b8mUjEZJeyd/vNUaQ+Z/hk2q7vzP16DesGIJ2tZDAJejmnv/GvgmFNPu0D0pG3+WVqV
 4RSCBEixqpQrtBscgyYltKnhsrC342r4XM5odzGpYDJ0DG710zUDwYKYcJ1nVbsUu/wY1
 wedH2sA561PLXmz9017T1JeryckqOb1QvAlKZ91IPWd6jYiTCd0VpWhrk3+nvBzstyY7B
 7FuZanFWON6H+/pEu7kVjqmm+9bDEAUG/LCMPD+O5nkuFJG0FG1LMr7s833jpCbAynA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793012565;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=4tOvNesHGOFOrWnb449cHgRTZABmrw6U/93Rtk+jPfs=;
 b=qo2U9pTtVopZOHCg1fllTuSYE9TPQBpFp+ox3pwFNnAH2gnOC07vRTPqE4Pd4+f+aRBc
 zf5g5IOixxu34Ve8asMD6IlrVWCHq69TJxww//E4wguiL3k9wRCDrh/Su7etA6tKv49Ng
 V+/L84+EqobRiz9NgNnLiMGLTdsvmIMWqRBGWZgyCxWNuEhiRjHVUMjlvjSQzZZghpRPB
 S4ZkYeROB7qk5wFAFat6i8YkqqvFRc0+UEyGtKp7P9Wyjmun/TyR/Q2FbwUYB0hyx/bUs
 T6KfAHHxT1BB/Flr1NlLnzhSVJUejvK8u07HeiEsLjuxFTOVmtfxRvpvsKPbG6gcY4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="MffpnI/c"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MffpnI/c
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D99840072
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:02:43 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso3983832a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793012562; x=1793617362;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4tOvNesHGOFOrWnb449cHgRTZABmrw6U/93Rtk+jPfs=;
 b=MffpnI/cAvcdAK+bNAHRJN7KcSAK7dYsYS+TlQlcvVo8WCUNaGR+e306NtBdmIqUMU
 R3NjK5e8PVVy443cGBJkSFIdVoC4xOSpJY8XSHw8ou3+2eb4WjJp4IOHLxp/09KBNbW0
 atAoNITbqHtl+asiEAmR5Z8xGSqc2dtfPNquRJVi1qzN1YFA5nj45tlP3VSl9bQvW3jC
 2YEgt8ihyGVmEUJlr2d3JCaFYPMFG5otLDhV5tGOzJiO4aBoMFPCWc/JaHJYSGqfhP+A
 1S20zLcLlCBYelSe+/d5WzcP4XNmw+hH+T0Xotxo1OlabUntUxPdfBMxz1yYYEQDHMHU
 m/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793012562; x=1793617362;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4tOvNesHGOFOrWnb449cHgRTZABmrw6U/93Rtk+jPfs=;
 b=hkT6Ty/TTe400WmuNt2DhOHB7ETiIURzuRXq1eGTjAAFwkt14IDIAmWr6NpIQiAeCw
 a9ged7lq4AwIAn72zLoJG+j/5cAFRv2T7hvRhWCn3bf9v3E2fIq77jWRsRA4FTT/y+m7
 L64RWBR/QoGqg4FeIDnm6OniE+dYXjjLZsiKqGd3HMKa8kqPuxAdqc6EPYUYjlgBjIlz
 foF1AB/oGjvlFLe0++x1LotKyf9TNOl9li2jg5IdN87TsgfHodmInazXBTgcBu+9yWLj
 x8f6IJihFZuk35fBD4Z78lK70fw4VKJS61RzOmNaR7GmSOUtOwzLls9VpqJora7x1MOi
 8plw==
X-Gm-Message-State: AFq9FYKah0APVSTsqADZvHO9pUefu+M6ZdIA+50xuSgDlVqumWYWizk8
 0QbcP7fq966LuPoUX8vZK/id6FlRiIaxjkGEZnhdnlGgpL80wo3DKlf3uCqYqjwAmqA=
X-Gm-Gg: AYBFou1ahHqv1ZwpjbsFbz4Q6gYzsz/0no7RPN8tFVkZjgjWludFxH3FX9HQvh5Saya
 je8sxWXcfp/HDkS1adDtIKuyg8ETIPYONAQTH7qLiziVukU0NXTtrb2cbJMpBwCmEc8nC9TXekF
 80IIA/DT1vLEHtljdSRW8v4u0rp+/xJZ0RDFs1hOsF9DBWEdZ19ruTN87JbBW3Rz0+UGnwz4mQW
 q5+BYTvHIAsMLEqSYePXVqGC4l9twr84dXtS+1xY/BsMOK9EtJVOZXFhBnmB8c5NC+tJeG1zTiS
 ktTEP06c+es8MzkonYAQqAFjnSkaFug7GJK2/2KlQSeqp/nxT0uLZa0LAtPk5Yqdzoq1qjVfONy
 /FfuXKY3Ux2jY2he6fEP/401GjXyeZkK8UMmSuCNC0UtcValsJuP7GbKeJrivgNSJ3Sab0uy5g/
 kjw4q1n/ciwXAMsphMI9KL8dzXPbN6Y1zpA5ua+HSJOeaVRfbBRCzxMDcsg5sK/cYALDRdIyLLj
 Rm6mog8QCC00B1++yb5qRH6v2VEdd6kvylKbqnLAugfK8I/mOmXD2M2pYqTDOzCV1RJyXL7bivL
 Dqx4L6/d1IwOIrqAxvGMkkIKLE1UI/qS5KmL9joehpP4kBXwAubiLhU02mCaDysoUV1f0pqe
X-Received: by 2002:a17:906:794b:b0:c42:4750:8d49 with SMTP id
 a640c23a62f3a-c46bde3aeeemr819678366b.25.1793012561560; 
 Mon, 26 Oct 2026 04:02:41 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd47basm17092600f8f.32.2026.10.26.04.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:02:39 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:02:37 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 David Lechner <dlechner@baylibre.com>, Ahmad Fatoum <a.fatoum@barebox.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Randolph Sapp <rs@ti.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Aristo Chen <aristo.chen@canonical.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 0/5] Prepare devicetrees from FIT configurations with
 fdt fit
Message-ID: <at8zMb82nE51dJKe@macbook.homenet.telecomitalia.it>
References: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
 <CAFLszTjmz9vVDfWn2wbr5_rBeYNhUorC3U6gTbziKP=SR_9n5g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjmz9vVDfWn2wbr5_rBeYNhUorC3U6gTbziKP=SR_9n5g@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 13:07:02 +0100, Simon Glass wrote:
> Hi Carlo,
> 
> On 2026-10-22T16:20:10, Carlo Caione <ccaione@baylibre.com> wrote:
> 
> > The first three patches provide the loader support, including rejecting
> > missing or invalid overlays. The last two add the command, documentation
> > and sandbox tests.
> 
> Patch 2 also changes bootm: if a listed overlay fails to load or
> verify, bootm now refuses to boot, where it used to print a message
> and carry on without that overlay. I think that is the right
> behaviour, but it may catch out someone whose board currently boots
> with a broken overlay. You could mention this in the cover letter (and
> perhaps in the commit message of patch 2) so that people who don't use
> 'fdt fit' see it.
> 
> The new tests only exercise 'fdt fit', so a small test of the bootm
> path with a bad overlay would be good, perhaps as a follow-up.

No need to wait a follow-up, let me prepare V3 with both suggestions.

Thanks,

--
Carlo Caione
