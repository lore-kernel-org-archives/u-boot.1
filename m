Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E76606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m4VtWLLn;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XeYqLz8j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AABC4091C;
	Thu, 22 Oct 2026 08:25:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id in7sv4iiiSfs; Thu, 22 Oct 2026 08:25:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D81EE40801
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657557;
	b=fYdx9fZkIVFlnXdF+8FJFKDJQ954MHT+M7TCwvmYhy0wK6sKCqjG3madIBNQbK3/Dvvo
	 bzSpxZYnuYDJTTvLQdePp0rMOYISTXJU4jx0uAsX+FN4tgA/1CxdyiTrcASOh3KKpeXXv
	 udcupXhvcHSubfloz3g1FBfvPt4cVtyI/lHRRXp2A5LYHDrA5Ns7MpiMndoec2+8LNDEe
	 fgEEVl5p1dKZDErVMWh/iudPPtnQ+DmoeoU8GAsgloSfyD6Ntd5xevKDlT4ONKKAofuiR
	 ARpYXmybRF9Rs5aQjWc/PpJpzRLKspX5JK8YoKJ07EqwL81e3Rl2LDmJ1rHaEKNg43g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EeVw+DGHEVnG3p8qiWOxQZi5+RuSwtn3HxY4YgZBzjc=;
	b=sXBJH+Z4i2X7N1co7b8bsfY6PivATWii5vPtY+Umi7W99rFdNvZivyI8EkGJMZ3+uv6A
	 E/NaECZ/W4arkXanLaD8iC/Clez14JwxZcfV5yvs45MphX8qZyX4DwAjicZ+L/3msutxt
	 E12N1JBqaeSboYbh25MeyW+IfX34Tit5X15Gb7UhvXyqk10Inu3bzkUnw38JDEryOTeNb
	 +h4/5PsGY2hJIVmOd/Oikyt+WUxQgfvw7X1BvD2sG2hyp4k7fuKgHJqzTd0LUTvfokjj0
	 mRZ2RT7YsXRP6nuxVKf6JOjGIbYQcLan1DJB1O/Fh1kvM7KkzOSevhrXh2uV+HQXD9A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XeYqLz8j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657557;
	bh=EeVw+DGHEVnG3p8qiWOxQZi5+RuSwtn3HxY4YgZBzjc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m4VtWLLnoDSHhSGxmVH6m/FqHRZNNAWLkk0z1UMc4aFsqbPEkkruGrseb6S/4kvJx
	 /wZ72WXOnak62/zYBZ8ZS7EqvP1ciDXgfo1aThA6DMGcShblZdLlBkfWChTG2mkvi/
	 UIE3UKjek/6EnpJzJ1KmcsnR/rSc9RDnJoaIT+EEJAmoGrPd2B78OqHWRHV7+0wC52
	 q2J3ZtkhTBgu5b4pE2n/itiGvd0eYQNLSqnBM5rPfAjRjF5S34qYt09zJu95fVlDGB
	 haqn1y+k2jGoPIxTfx+IHAYh4XASPqjf52qMYys8LKxVVQvectWWIcQvXqFAcquEKI
	 LfHo6B3HD5fjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D81EE40801;
	Thu, 22 Oct 2026 08:25:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6443235
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC64D407E8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJpeKDquLssj for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13792407AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657555;
 b=EKCbPhTajV1j66C9aM09sFUbgdXrPmNta8bLYCHPZjwUZ/0VRx+U84GEATB4LX5VEeYI
 83hsWkdkY8aeLv6uU+NlX4nMoBFa2ElEhTtTVgj/V1THovyI1V/DUDPJ57D2xiX/4RvM2
 AirM6xnQOFtIoko3VvbDHKPvwvgVhHdVkrra6oNjvoofJYFyOz7gsfRNvLCHZB/XRsRl+
 Sx7X/mXAGoQlCGxB1OkgMOU1L1svl/0rxxgGlXmIuklYxu2XmcLxzUW+diOG7Fki1vHYQ
 ljRZalwnSV/+RGFhGQ4b4mZQfOGYo30LrV/+XZBKJyxMhadF5YF+t2f/CnZDe5UgNeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657555;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=EeVw+DGHEVnG3p8qiWOxQZi5+RuSwtn3HxY4YgZBzjc=;
 b=flZmhgT1duBbLHMNdufPC0MXO8LO1oX4vmws8ohMjQDXN0dYKtb0DWKQDvKGBONZYGIn
 x7Euj9SoXnI5d8mKAxfD70WixEpQedh3zeG3ZfpSCRSRSj7WnBJejfvw9Qr+WgYnBhHtZ
 i46MiIELJxTvWzhu5p8Zedps3f0vrbV/8lYdZ+9Nq+4Re9fJzOqfnXSRpgzm35+IdjWv7
 KnVL3Xp8S+3l6KYFbvqoIYFKU9QcsawnA+9/ddicL2AzkVdpyNNhv9pfwO4cLh6FmY/CI
 xEDNPsAq3oDBZxXmOE70wV1rMJmZMlxFUBi5HziWHTmB1dNhYNMy1Bt4Mk7LFVZ9+2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XeYqLz8j; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XeYqLz8j
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13792407AD
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:54 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e96502e447so12309375ad.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657554; cv=none;
 d=google.com; s=arc-20260327;
 b=BUjEULoLu2dIK0IULbu0FEl3k2IJAxPT7PIt4D32P25i+ufPwSqTKUH1Opfq2ke8UP
 kEs1YgJJW0689TUCUSqFBVWvgqFesuaI5/CksQ+dXA9sZu2TMRmVRJZDgMl0Qy30c1Ow
 taqMFm/n4h6gbCCYa+02uLvlQdXD+4prvpOn8P2SfbvFfS8AhF6+39A5EW7liAaUdt5V
 DQxNwVNFq4bEjcaoHl/rbTRTt0ASuX3420omi0+M6TOVN3iGwBfOg7ToPPNziiqsYQJ2
 n3S4f6PKq8ksijOKXDLOPiHjBCeqb2xy20I/fUqdy3Ps37Uo10clCfDr2o8zZBNDD5aa
 zUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=EeVw+DGHEVnG3p8qiWOxQZi5+RuSwtn3HxY4YgZBzjc=;
 fh=Or4cSwLZFrUd5qH0qAGTMqaUBZmtyqg0jxbTqiYleQQ=;
 b=RjcmzW5qRxVsmmLwa53O8PgPj3MWsCzXfpEnR0z42sx2ZtMxOj93N6/lf2jsOgITKG
 RlMAG3fVQxMpKNvE1x01TAxxlF5rpYftJ/qrSA1W1mGycY37pIIZNxZMj8xyoSbdyg/O
 DONz5/7Hrpgpq/IIUvoRfaOHS0XkK/GG4hEgngN1CT10ocAElV9/XM9RtPaiuwXtVSrm
 m8rgKeBqve4AoocK6/VbmPDwG//H57W4imIzY11+DnmSiKsGtD/b4fzKuRZAynIYsdYO
 JcfwaCKjIq04kKP8kh5aA18f0P8ffRt80GTZM2QO/1T4d2gMrLaRQwW1Q75bJDLjT7xg
 fAtg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657554; x=1793262354;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EeVw+DGHEVnG3p8qiWOxQZi5+RuSwtn3HxY4YgZBzjc=;
 b=XeYqLz8jDJsevfS3oYJTHvUbW3DtE8zAEvt+yVokB1GnShE9v4pJw3Sr/EQVqV6ODt
 CEK2jtNV0H+/7YLk0HytHbmVWon8iVRoJj3ku1jOiy/V/SdZBFTZkFPt8DF47qNayoJ2
 5/MYfyEf6HAT1kdkzwGe2WkIYqqV29O7jrcJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657554; x=1793262354;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EeVw+DGHEVnG3p8qiWOxQZi5+RuSwtn3HxY4YgZBzjc=;
 b=UJdstpfmq8+4ps+88bcaS3t4IoW1mJWY6jQ2CJgbNuhvonKQtJA7C7Upyf9UXTeMDw
 GZPuDlldq8tVOzHJCr7xgsXO0hPK3AKXDoz/m0xqu5DJZl2sX9BeyyYcg7WUUxz0Bb4X
 3V8zH1ucDI1D9j4RL/FeP19p8y+1VFU0uXef7uITQyHqnqSuxIQyQt/WCX1adZhejWM4
 rBBMWl/nY2R1jpevAayQG5WnpdtRKvHRF7PxvI7P2DxaMDlj/xohOJze9LdFcb/AdPj7
 fvOBp2EC/0p3hjuwRv8/M7p+V0WiMUYZNJ0TWZ8d8piEjarK6q1gvh0aYh8RYy/PZ1D5
 PYlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByG+0jSS45It6e5ljP7Xsh0E/fL9Qr1xk8+zMQRbgMi9xG+H1TSlMwChNPDa4cVddlc59lB1NE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIU4rZKinx4s9BjeX9pubqNPn0BQJyiM9vzqPVdVN/IhARIltvC
 627FsJ2UrLLrq05nhLGFCw4Rz+V1d35gHx61wURETvapmEwmk5qIxrtjRqV81MJmsiw2w/t3hAF
 5SOdEmMM5lDoZcuUwU4NgnlhtPACyM+0tUJ9oPv51
X-Gm-Gg: AYBFou2r42Jdwcij5kFkCLbvqV6UL76tipZRRfWrKRoKR2hi7/6ont+E0o7ahU0jM4q
 rN6AjaIhGE9CaLQZfDdHgtcsKPmP1rHObog/0fEncxo3Tm7FxqKMBMq5vNtTzjVArDbIL+mEjuE
 8HCQG16MAW44IQ7jjMlH58eNWd1dqZyQgFLfrkX9UtZkVd8QslXy8oCr8BcAbMgyFhIq0acwvb1
 YoKU/tQG4Q+qTcb0YjCx4z1A5xuSx7hkQPP5e6jti0WqNJb7nwHM9/N47l8MS49zTkrTArS4v16
 8B7zJtPbzTxeIU+7TP7ZXlW7R8c1+SyhieL3BBJdV5NVYIsWtvwHcTjttdit3XvgUBgFNAsM63e
 AzeSHmcGJ/30Qe2PLuv/hr90DFaPEK+1BFko=
X-Received: by 2002:a17:902:d492:b0:2e5:db61:e5d4 with SMTP id
 d9443c01a7336-2ea43e50b73mr39780915ad.62.1792657553719; Thu, 22 Oct 2026
 01:25:53 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:25:47 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 16:09:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-4-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-4-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:25:47 -0700
X-Gm-Features: AclHuK__2xmrmeGO2tKPMi2Nse8poygRCFui_oOlvag3V_k4vU0_B2HtPC8ZAqI
Message-ID: <CAFLszTh-hd1stLrO5pDQZkOLvNCSPLReAukoF57zKbWE9vCu8Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] test/py: android: Use for loop to create the
 images / update disks
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: android: Use for loop to create the images / update disks
>
> setup_android_image() creates 2 mmcX.img files:
>
> * mmc7.img: For boot image v4 support
> * mmc8.img: For boot image v2 support
>
> There is quite some code that's common for both images. Currently,
> most code is duplicated.
>
> To prepare a cleaner refactoring, move the image descriptions into an
> array and create each partition using a loop.
>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  test/py/tests/test_android/android_image.py | 48 +++++++++++++----------------
>  1 file changed, 21 insertions(+), 27 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
