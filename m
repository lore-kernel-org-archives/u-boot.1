Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1E1CCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB68C814FE;
	Fri, 16 Oct 2026 14:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1-mPDaDjxLB; Fri, 16 Oct 2026 14:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BC022812D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161290;
	b=jnVQY+6XeTWDPJjLlEaxE2bQFyQ3Dtj7lPMZvOmHkmpt5a/rpCqQHS7Pm4CzYezWpIQ1
	 KFSAEWJshZtUYtSBaIwQ5MnuRKbIzpvikFTZAENMsmAFbM/EhxRwgVdHnb4Kc84vNYqO3
	 SBbuFvROiCFZrk36U0cPOtRWLMzwFe5ShMmH1uDmqEDxV7uluYlec9FIqW0sG4WOBDPR8
	 8LS/dHrtN8CJEXI4fGVd6B/CWdaIDcIVDbTKELbumkBHPQawRBouChiJC4cGaBlpdA0Px
	 kac3udwVMMHx95fJZbc6K2jk7snLKkXlROdNQ9KkWVWtoI4ADCWBb+X8yn+RZObvaDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792161290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HMLbWHiyMpWhyt76A7Sj5UrgmP/04RLbaXEY5pyvfxw=;
	b=Ybqn06H2rI5dKHQYPQCvuHuNG5MlE0TiEKHhVxmbsJ1T2bmRD5dbS3AEB2Is87GkZ4to
	 7PGBh3M77gd+58D5uA1YxPVu5hyUrSjPUK+584B0PbBC2B3MFDPNHwu+uNIuhxj/hm0OO
	 ZS0Nx9AMm+0FakAXHtIaxnEmyaOAt5fbzt/5KFFc/xe0+Bj8sRhIX4DwDfiSbS/EXGrpn
	 vv74xRwLwD8E8Y8o59us40hOq+8fssEiEWtTm2D8KlF6+GCdP4H9cDru1xsBInbK45ivV
	 q/GKXhr1UMMq+bJyQ83hh7LWPhNg3UHQaZH5CSZKW0Sm8xM1Fyobc0Sz0g/SSLCx5gg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792161290;
	bh=HMLbWHiyMpWhyt76A7Sj5UrgmP/04RLbaXEY5pyvfxw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w4xDnwA2KQL/0S18VpoJOgU56sDVUyDljPQhlu1N7NKr9qwIQM9z7p+YVmRGsLgRX
	 Y36b9DfWuUXhYTovYHVtMXPkJY6YMPdDNc1o6xI91WNZYLhJedQac+/YwWTiy6iBgB
	 SpOdH1stY9GryA87dPspLrMIMYexzbk+E0h3VHQNsPL0fXKSSv5X4He0WiSeXVDGsu
	 eNLXyvvqG9tydSmP2OTBroS2d28ZqG91m/P6eVid/ZHeNT8zIdIMmrH/hKJncLUUrN
	 TL+77OrdwQMazpRaJVsmT0rmj4BFnJpCF8VcdJzwCMwyWHcKaT6OcRSTNfvuiPuSBj
	 048oMsU8MjGDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC022812D9;
	Fri, 16 Oct 2026 14:34:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3853255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E160D40791
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0HWa0ljL-Xg for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50E46406E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161288;
 b=ppWsDxWA3lOm5uxO1Xyq53oI1CoZWa9pVP0A0WUfqnGK5133dGhCh/cewTUIpCLJ6IG1
 SjHc6utWC96B31+PiGJlZ+4yD/BBCV8kGNyrISEU6wFNUfgHBMWoIl0fC1T0yy7D0ULLh
 Ct4V3YJn7IPWc2cLdz5JIjhdE2ASu96OLmdhr+XBDa3Vpr/L80aOriR6OOAQEU08sLMaX
 ofrfI/nj3+h1LjO4zB2f5kXan/q/9N7fgqFWHBlAqPQO9IrKeHZYtpGt+cqc3BAf7APdK
 ntlecxtErU4VcNMUXOUtH0CQt7XhrrxM/eGYmZeGay3Y7SHSQpQpj87V/iqsBQa2nGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792161288;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=HMLbWHiyMpWhyt76A7Sj5UrgmP/04RLbaXEY5pyvfxw=;
 b=dTUn3AZ1z2Fpoiwsm/fQqUTwfPRzebiySyv8xdB7aQhNP6LUN9pA77tSpja5DAzhtelI
 foROkxCNSZIFGOHs1Ssj5G6+uTfMD/KYPh1g8P0Cuu7Z1YWemShGA4Qn/ilTxNrUNGQS+
 Ufg41qMQGmqWyj7fMNgkzzhPDcunZs2EhPGlFyXZsp/Rhf80itz1JQaBOi1JCixpAWOvX
 +9ZiKx/lwHRZ8/bXQn8Me+m7ndIxDeUEfcSXL5edAEAeJtC1M2HjU/IlSCv7dULfLieeA
 +29C5q9lNHjRunAltHgPzQZEIoE6M6MTx9ph+BTZso2y5tj9zGpNlIBW+u/NWxpG+Pw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AngCUwcN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=AngCUwcN
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50E46406E2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:47 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so48289a91.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161287; cv=none;
 d=google.com; s=arc-20260327;
 b=GfFpsF04vGHCnjvl63RosYEVtcT9I3HpIPF198H6n5MausHGwYdVoL8BTSIMWUbBvi
 b8JGQcvgYNxbv6fvR7bUd32lyfszHcf1NZaY7ure59zZbTN+/DZARjAmpRVMeeQEgbiw
 rZSiWd+UPLP9sqJvKopv7RUOX02GknhrEAHPfkwRXhCaJgzVPcJ4q64r7DI9oGZa57O4
 OzzrwTZbh9brQwDPv03LPFdZfHX4C4GcUf+zoWTqYY9YK37qzSsrverxA8z4x67nx7AB
 cVEuYisGd4f3QhuQlMvgTcu9kgnZqqUo3gTpDBIUEhbW3Pxp5iH5J5jMgFOExvYbjPWP
 yTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=HMLbWHiyMpWhyt76A7Sj5UrgmP/04RLbaXEY5pyvfxw=;
 fh=uq5JI5vGP3EIT0xidF4UWDu716ygNr9WzUP37XMZgmI=;
 b=p17BLPFj7bZRBty8lo3P2shgP7IYQpG6nUMOzU2JaY2exS9A5TZFAEkR34i+x94z02
 VqKp2BBh3qUKc9m3tQBSWaDZu/QaC0PKmfF5mF2viOYNlX432TjTFSGpvhuoZ0p2gQlJ
 U9OHc2sNY0YYHDdsi5JbgqF6OH1w2bMKteAUmQM9d8IZXpIS42E+io72gNCD1QkAaXaz
 1Bw6KSL6cBLYMlC3S/r7Trz1FrCWo5u2GXRiIFnvjNpb85wIlnBBoK8r4GfY4xOPIYdk
 eOmxlsqk6GSu/PtSYbwu7azc3BUPYJtfxS02S+qCIO2Fw5aUfjuJbiq08RmGe9rmOZOU
 /zDg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792161287; x=1792766087;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HMLbWHiyMpWhyt76A7Sj5UrgmP/04RLbaXEY5pyvfxw=;
 b=AngCUwcNa9G+vmG2LljylYZ+6k1Ud250CwizxflCnvNwLDur79fQL8CIOCya323ycK
 8RYU7HE+d8sRO8Hq9cEAKrRLoAg4VUjYq9wdTUhgBug4apjvCVimBDdnCKMCt9ki3zQ0
 fGBMjemw12R11OWf2UkY6vIrxzT1VcvDY9cZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161287; x=1792766087;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HMLbWHiyMpWhyt76A7Sj5UrgmP/04RLbaXEY5pyvfxw=;
 b=0VmEQBytKv5AGBdedPghL06BETNtmlTksa+kD2X9RotfklvEN1zjT0ZxACGrcF7/xO
 DdpEmWFjEO+n0DBVzllM2CHOEQdE5WkPxe1+J/3aISOHY8kUc97G+zwC2AcJZJcWBLk5
 8/gaKhYXDloQPZdBJ2QwRxaipk/mPArVxRjwIl3iXHoNvAg6UtqoIHJAxoMELfak6tKX
 fMHmvBxCnLW51SJHssaP4y1v4hPFlzLV3s6V9WpQM2n+rmRy6cEMuwxQvp4UUCXlFGGG
 /MPRcznLyNHhlasSK76xsLG7qn2nzDnk/HeesV1O2/IonSPn6jJGhZVwJk9a1bwMcuXk
 1kBw==
X-Gm-Message-State: AFq9FYJM+IJpWPYEsyv8P0d7pBX9R7rMBM/JVgw7tmo6LsCF1J5y+U6Z
 4G7VQS4+t/FP5G1PYmBAfhD7ZdNibRZVX79vDbloTlS1LqNtj42wnWLOmORhG44H6RUXUnSoZeZ
 PXLPy+qADbFWe0Xc6sM3sK4sIuhr6RL3r1gCj+a6S
X-Gm-Gg: AYBFou1HltuvMaxPtS7y2XBBqXGoPPkuqNNK40jnno7Q06U7NfQcZ+CJeki9J4I0m/S
 8HY1FRL16S9vzqvsOdzxn9B7XDcmVwIllMUWP5aJ/am5Obrc15hsTxYT9fhyPXCeUfGx8y4oYQf
 IesporGxl9FgznslK1gOksfF6B/SyqOAaKm/aZfgX2FhoJ0OhmojCsTSF1bp8+Z9BTys8vAtNDS
 txiglBa/x/Hp+nSa0TaBRtfnpGvIwKQid9JFqbqstviyRtE+fSVT1ItuLwhSeN+djr1jC97i/RH
 JLPm74/24HhQEMTIfL5rS1+IkAn+vEycNEHRhmutMZGEBMCSxHltvw==
X-Received: by 2002:a17:90b:570d:b0:3a8:9db2:a4f with SMTP id
 98e67ed59e1d1-3acef527908mr15082a91.51.1792161286875; Fri, 16 Oct 2026
 07:34:46 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 07:34:42 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:59:30 -0700
MIME-Version: 1.0
In-Reply-To: <20261015111328.1269775-8-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-8-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 07:34:42 -0700
X-Gm-Features: AclHuK9VATjAB-g1feIWnEoHI1mzu0cgnK92hX4BmzU22wEhMEwhb5AkX5cZ0Qs
Message-ID: <CAFLszTjcqC3i4-hzBjTHtnEOyv=SVF7Nm9G0PCLVcc_8KEGUtg@mail.gmail.com>
Subject: Re: [PATCH 7/8] MAINTAINERS: Cover all virtio driver-model tests
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-15T11:13:15, Bin Meng <bin.meng@processmission.com> wrote:
> MAINTAINERS: Cover all virtio driver-model tests
>
> The virtio entry only matches test/dm/virtio.c, leaving the existing
> device and RNG tests outside its coverage. Use a wildcard instead.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
