Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B33606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X8SeXFw9;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LUVv6mCH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 651B340ACA;
	Sat, 24 Oct 2026 06:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4YyqFSKX8B_n; Sat, 24 Oct 2026 06:22:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97B8740AC1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822959;
	b=IMuYw+wgbipJwskJLlsQXGldtrtTMJwXB66Ncv44h8z1eq55xJyZRtnj5kxqKy85uhVY
	 yI9Jkp0RIPwultedP2qIHW4HFjCAStJmGd8lPpaijPAAiPGKD/+WWRFM9kx6QXisCEvh7
	 6bO/ZXmajy/4LlxNX5RS6pKBLa45g7Pps+dzw/Sl/XIA9s59PYqijURh+OfhYO8dRFDTs
	 nnzunZCQzy7ltN2QOxbNiUHU4sWXS4yRfgmfuBhE6o8lFuiaMjXkHfnsBdzdy7I1BeutV
	 KFbP12FQhcNajKXbp6cnNRhDoTAaOrDC9cxUO5cBuUGD5G1YmL5MC54T7RMOyXIQJcQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792822959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xqFkhDZdYlhXrNh+QThDdvERN/eH/A6Zw4XrMej1TFQ=;
	b=EX98PdKmm4KA5asEMdue+b+AqkVkI+PspQEJxGAdxvSlEF7fop4FD0SHHuUvq+eP/BtE
	 P/RJQywGjauJNS9dAvXecnm1dGa/KbJ7to0WF24V/fQtjCh2Js31kks2aZ0DtReWXp4nr
	 pFuGKZl+rDOXVm4KfGTEkRH9sd2YE94U/Uc4fwI4o8iXk49rxq9udEJe3c13hI2pftG8k
	 NEDSYCkX7Hrm6FMopMGsOtoUOQzT6948Q9Pe1qY1MwsALSsOZKXS1EPEtxRqFpeQwnBRg
	 InFjAUoncv4KTNoBOZQ4U6j37hT06S5aFI9NSClPlG5M66U99KKNyxZtcucqwYNpbBg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792822959;
	bh=xqFkhDZdYlhXrNh+QThDdvERN/eH/A6Zw4XrMej1TFQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X8SeXFw91c+Iso/TszlUMrZ7w1FP7kgRfIgA3BvI7MEgX5JsD1Fxa6kWaurW9wpl1
	 GarUwoxjwm7djHYfZetPHbjYaEraJNYcnxCw73NJgqnEfB+c5+phCvILvW/Gki/7hg
	 GwNUqesfjvTrjnYo3XZvwqHOlAKfMe9W+wphI7/3n8jYWsGrWh2sCGra9pVldQfpQW
	 a5xk9n6fUnXSknV9GD59NtC7ou67FBiL1WVLTuJDxFiuJxAlw0PJ7Gprdt8h6/9onR
	 QQ9gk1VJdBDjMMA4kK1df/jUsmvyAfrj89FZ/JCMbxlqacp6/VqbE8S6oJvP9N/ZCM
	 EnYGIsE/Mc2Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97B8740AC1;
	Sat, 24 Oct 2026 06:22:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 953FB3C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9195581636
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAFNwI_nDh0N for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CAA02815DD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822957;
 b=Nceq3gShro2/q1Posb71MAeYDefJ8Tj1uR7H1DrkUYU/+cvacLU52GCtygD6y3+4gbbh
 SvGLpP/ZsUdyo45KKgGcgJTEv/FiahB6um+JrORU93nC8U5mQhbwEH8dSNg6jW8VgqlLP
 ri7qmwcqbXbkBV4kHTdB+oILAAgVsWiAQOgCCXJyUlsRNCY3s5251aci8YbRcJ1BcMP50
 jsMrJ4rR1t0QnbfKaP0YstP3ZXYOM1e2WKby4VQXrI1/T1KUcvqc6CuNwbw10R/1own1E
 09wWWX3s2pM6q9+pOmkj96QTB81pGc2ySBFHmk1U8dkdcWoxrq9TK5mFxHKSgHVhQTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792822957;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=xqFkhDZdYlhXrNh+QThDdvERN/eH/A6Zw4XrMej1TFQ=;
 b=gHDAdWecbhaTEgCsT2Zj6893aNI6wOX9KRgxCl0ScrhjNjWiOV1irjP57eidjYAMORsJ
 ebTnA/OWblZ1sh49sl+deif3JsbnKjq5yzMZYwE4WNnVnHEU1DCwSgn2nGgORXufO3LsT
 qTCwLVxpKGpHQFa2JQlJw4AtQAvq+r36edxdx/H74hN6CV2GwBVcU7bV8XCYC/L2GQwgR
 Gx4nS2QsLcchQJx/uX9kGhv57PI045Haj7V92RVxPBR3Ds/XEb3QyvRr9zMei8rzpRK7V
 GlYi+uvwUkx+vBvqwd7XHph/uFVmQocbjUmu6vCL36f6WkpFLwCc3sElrb/JMmTzrow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LUVv6mCH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LUVv6mCH
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAA02815DD
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:36 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cd623dfe420so1129348a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792822956; cv=none;
 d=google.com; s=arc-20260327;
 b=aXUUCmmvkt7Bwf03IYfw5PF9SRc7RL0/OLJ/YS1StDO8JWTgpOEivkjJv0jkUpmWhp
 VeN25DT7XZPb6+JGVt2IGoRRv6SPkdDjbjMMTb0jX/NDLtN13F1185Ajfx7UhTSwhVii
 XuEEzv6DYh6Lh3jhTbepHN+lBxInM7Jxrujiw6GmYTgvPOqpwiSIKZk/k6X15c22xBag
 BKldwWVWfFy3bEdNlQt6b5Xfm/oZqvTYRwlu2/PfNb20T4BUDimzYaV8zgd0NBsI6toS
 A7Ccu/THAHGOtaJegSdPGJBwIDVq8cikZezXuhtpzIRS8S1BOu3IELRoar6gxQtxTHnc
 FmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=xqFkhDZdYlhXrNh+QThDdvERN/eH/A6Zw4XrMej1TFQ=;
 fh=4elKA/8R8nsp2QSEXfJoIvGF0mo+aUc0n1hMY1echd4=;
 b=Kmxf6KSCwMdYfepi0dbEvvn8qQ6jsEpuAz2d7tSO4r/jjox1ji/ASri+9QcMeMd2pP
 ZxEC9JIPTE1B+TqqiVw6WD6s3CNbeGgSXnErx7OXsOUe0pl5bHx7s8+afNZesrUdvfI3
 2CRMwIV7jM9bbze/hnkKQC6LIinQ+fDN2VbNhoNI0N9HB9jgMZ1GseMuhnNU0N+j2lnU
 juJSvMrkYw7kwhw9vSJq25F1muhg6wBPaRUs6oR6fk99nhB56iE46sLhAExQOqkbIAv9
 KyJftUq2vXTAQDM5pcueha7jQgO7Tje4jAHqBCMcjbtupJa7UtUQbbVSgC0Wgm89q7PC
 3jdg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792822956; x=1793427756;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xqFkhDZdYlhXrNh+QThDdvERN/eH/A6Zw4XrMej1TFQ=;
 b=LUVv6mCHLXy5Kp+TJoGM6NvRx1UwrXYwK3BwGxSKnHPJgE4rTGmBU+eg3pFzvMc2DA
 J3qivdGaP99DlZoBn4igB89cH7Rewju4TNhWUxSR390bDtuC0GeUP52NJ9bwGrZJ3ehH
 9hbrp0znXg0kEZBnyfxwcEM+h4ti9GcNYdonQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822956; x=1793427756;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xqFkhDZdYlhXrNh+QThDdvERN/eH/A6Zw4XrMej1TFQ=;
 b=Ean82HjsFtT1GVqoQMiDSfyqeVGqW67IFJeB51uh6HXz4YoeVqbk6yJILvQ6l32q6U
 Ggx6X2fz34C+euCw0dMd4tADZn9ZM5iu79Fl9DiMB1yqZECkMed8vH2gaXyDBy6mAWnW
 dtlyamUrkPy8dC0/fHdIC/X9JCelmj3g0pOKHuSZ/JvfKvMh2+LpCDvxOqS5aXxw8X8L
 Zq30a5rZw3hnB5GR34hAmlo8hGUwoJWL+5dUJHKLH+f1DV0Ka/9yzfImURUL6+gdINUB
 ApZ1bXlSXo9n7rf1O9bieQx+Xpj5qIpKfOWmUJ/ALsikMGQjk2giAvUwvtCAr0LwmS9z
 03zg==
X-Gm-Message-State: AFq9FYINi2Dq0EB5d4iQ06KRw04woDJ8F2GRVEo4Wr+11L9uC0sAP8oB
 3GwHIflBsKVZzE9uKHvAM3IgEiDWWMEFGq6Blz8NbzzY0bXs5jw7U0msTymsTAfSJ6SQHQiMuMy
 6E7k+7oIeAtlRa9t5wAeNWliNWYiB04UMX6Qcv6s/
X-Gm-Gg: AYBFou3Xk4hMmpjvGA90nm+ztDZmWmmFZ5LgnAkGL7qy0ErSUpuJeRbuhAa+jXq83Y4
 fa7R4RVzwkWr7hGVi/3KuWprjvrKmi0wprVGPBgeTI6uULMBU0+s/+e3/iVs+reW03qOwpH/fPo
 V51KQPccywFROveJPKBf351cTd702ogp3nr/FaJ8k3CUe5eV30WhzVKQqkMZb2hAbN5N0piJhpL
 CPsKdOvBs+ZXYpzCC10ChSQ3ey0j5OIO86AJTZ4SKZ+2PCsj4tJA02kIvefcii9xscIxGUgHRYB
 DIviLsTps+x7QjaugUhbR2PaNy1DcUvTlR4MAktD9U081Raf+DZw8kz9FIbmNttYNdX8lnbASMi
 yY+VfJ+bsOaS4MLNTu8FXfhOjqsd04wWOYsc=
X-Received: by 2002:a17:90b:3c92:b0:3a8:2c7e:8986 with SMTP id
 98e67ed59e1d1-3adeaae6322mr1172936a91.17.1792822955599; Fri, 23 Oct 2026
 23:22:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:22:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:48:50 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:22:31 -0700
X-Gm-Features: AclHuK_I-ljbKc9EEZ8mNEWlehThtRaqs6g6iYpVWptKzE0qfhJMfT2CzQ_sfb0
Message-ID: <CAFLszTgpzxSZGFD9tPJXVFCpPEmZtaiU+zXpUkvHuviuEiBQQQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] tools: Accept .key and .pem private keys for FIT
 signing
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ayoub,

On 2026-10-21T10:26:22, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:

> File-open errors are preserved so only missing keys are skipped.

This changes user-visible behaviour, so it would be worth spelling it
out in the cover letter. At present an unreadable key (e.g. EACCES) is
treated as missing, so mkimage succeeds without signing. With patch 1
it fails instead. I think that is the right call (I tend to agree that
skipping silently is a trap), but anyone relying on the old behaviour
should be able to see it from the cover letter, not just from the
first patch.

Please can you add a test for the fallback? test_vboot.py already
creates RSA keys as .key and ECDSA keys as .pem in tmpdir and signs
with -k, so it should be easy to rename one of each to the other
suffix and check that signing still works. It would also be good to
check that a .key file is ignored when the .pem file is present (and
the reverse for RSA), since keeping the existing preference is the
main promise of this series.

Regards,
Simon
