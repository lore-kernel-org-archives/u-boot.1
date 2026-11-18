Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F395606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0fhMhq7r;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+GMEGdO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4533D8121A;
	Wed, 18 Nov 2026 13:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iFeF5PpsDkCv; Wed, 18 Nov 2026 13:21:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C60A811ED
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795008092;
	b=ANX37SxsARuAAJAChxLQwxVQLAwHM5ps8ExRcBH7+IJxnwf+zGFQVFAUtAA3Q+xijQSK
	 1+tdjxb9lZBV2Lou4hlI+jsJd5qjahHOh54pymfIzC8C4kPqrCbRedLdZkHB0dSWdGZfV
	 T9uB5XQQk5qx+x06M4EuS1GozIhFB92QK7BKGCvUXGFvgisd9xPR9pQf/7XrzmEcebjVc
	 NeWuH5bU3xtqCDEAUqOLQe1eYWdo03/AHQIWDEVGW8udQlKV1ZiRbkWE4UWKWUNzqUuQu
	 n1cFND7l6aS/0EPZw2Lgdw7yo/0zuIi7QGx/zCq4TeL16c7pJ9Riiqd1pzCfQZyl5jQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795008092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=veAmnveNHEfxInJbrdPboLvwzX9mii7HhxWc1aMdNrM=;
	b=d32hRK5USUqeqbfH1Sx+Vdwupmkj+2Zki9cOmXAmZHSRw6U3FGj119+G9UYql1ffOn73
	 r5EFVtxP97+5s7jopGEVQ+33uv10runTLyTdvA3vXPuXlBzl4ikSXQZxe3WWZG1TvHAom
	 aKaSihzY7yO0RgXEQB/WL0nfnFzQy6FBC8dbM0fvj2aqpcGvmquKjZApXMhNdMp5kKVYU
	 EukWXHnWdZ1/yH0+evVj6/fKC7iJ8MddnkLBiMRwDSxUCVoyL/JC/OS1isXR+zUZuZxL/
	 X3dsLLLwRFsLpnlnoh3YPfpW0yMfMbFBNJbctdKB3TwQELC7NPVm1TTAKBgt1Dgnb3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+GMEGdO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795008092;
	bh=veAmnveNHEfxInJbrdPboLvwzX9mii7HhxWc1aMdNrM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fhMhq7rG+CRfLofzoGpMiKaMHwtRfUY5PCjE/Qo2MfnO3TtxP/BqCZsiSBWH8PTC
	 pFhMUIChqSGAqv28/mvE6TDtLdYa1qhMlSdzVDcCudPoGu5xo34raiayEyESWPIc+v
	 F6lqf0/7K64QYsSG9T0xnyAfv9B6Ii37Awg4euSR26oS2++Zdjz7IRdbdLab+imCdm
	 7W+vUoRrh8K44ZP+XQ0607s4dyMJdTjWTbhAs4aC9q5pZQ9cpvL/8B87nRb9uGAsCd
	 3UmFwttr8jNyUlclXvnDr1/R2vTHeapeqnn+/uVS58mRSzJYKUazDAw2wJRhI5xzdt
	 7nOE1o0RrDp6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C60A811ED;
	Wed, 18 Nov 2026 13:21:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B0D1A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00066811ED
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QV7O-sZ1ykPr for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:21:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15D50811D7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=K+GMEGdO
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15D50811D7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:21:30 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c4d21051042so145056566b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795008088; x=1795612888;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=veAmnveNHEfxInJbrdPboLvwzX9mii7HhxWc1aMdNrM=;
 b=K+GMEGdON8uUec1L1TCsTM/9GuVjzHNiPDtsm4b/JOyfxrqA+4L6PgyoxVlXvlQM8e
 KVvJiG8ULHe9JS+ROlD7EjArh+E1QsTVLvp8nHdJcXPZ2UzNzp5Qhv79baKbNjlu7m/I
 ZWigipIJPG05oBPJUFjjVOzYiKl2234yC+D8icrz3a5YRhm5SQGTloBFzwG5s/Nochx8
 JC/GW2KqonwG920+yQzfcpECYbOTG57XBbzJZ2Oar/e0drm+LZWTC2ZkEd0FUBihqwIs
 s9nCGC+bT0zJ2bDUEoulxoG6h3/y/SGZO3H6UjPZsYh1Qi1drKwAQ4EwgSVD/DR0gb76
 q7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795008088; x=1795612888;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=veAmnveNHEfxInJbrdPboLvwzX9mii7HhxWc1aMdNrM=;
 b=fpRd+D0tu7H108Z+JRXYrA/yuJCx0uHTk7U21b9hvko+HDuc6biU5I8gpIt4thwbwi
 ccXHOCRgHdgpVkjrWF+CwQOZ1jy5t1pCXckLeCuqScMgmaa+F2dMSdi65BjbO0JH+F1Q
 BNpcpOO/W8oreQrrYXJDZ1LuOe+PCsI4k1Z6JDteQl9bCO4Kv51qn2ARbu6EW9uJnvHA
 k8UFPnkrDCBUHHYxavfsTYeZWg6fKu+QKlOyUuRqGQyWpUtMiGv74kaKb3zjA23KPSJ0
 mefJBcL1zlZ1Pcy7ecHoWqzyonUCkGwxHZY6aGfIwXYpwyMFRSOeBRgtfiHXPb//MBc2
 POrg==
X-Gm-Message-State: APuU4Z9px9XUzQs0L60XDRFC9s6KAXJUGm3qEyj3KJoZORQptsIQs/Co
 9FA9IT+VJxKZN7mwerCg4o6+E3Gy9Hw57TkY2ovQzpy4/FxYR1W84cLJhJ9IbOfxcL6AuZ+0bT/
 dyijTFHXX+ocPRwsWPUQ9RgpyOCzfd5Ll6oAW4/B+yCSP
X-Gm-Gg: AYBFou0nVjSfvYawuQtZNtWbaCDfSBqmqswIjOn3ds00TRqWCAaNgBHihvAFii3UdE0
 eKl9/FAtTISvJ8yiyhWNjgDb0sT+yCIbJ6M9S2PLu5ILRxbrcwx+g3cbgKyPRo8Pn0tfMdtFBxW
 RiEtOTM9uvgM7iVF+GNOptahfJs86ikLM0NB4o+ihtQbPKvxEsoxaoVWzLQNXA5GsW+03vd8KHD
 ZnTROpxGMf0EIEh5oWlHvamnYRE1zZP2fRVmKz/5bPjGklWauLqd4Nobav0rbReB4ng6XESgB3I
 unViccrU7pn+QWRzfA2JmiP+wVOpZRUM7+d9IHmntlD2+y2sEOeUSWHOrYeWgqXiCk+gcz9jj6D
 /kqkKRbUA/gsjejmRXiHj+LlzMHj6KBq7iqj+DQ==
X-Received: by 2002:a17:907:d0a:b0:c35:3880:773b with SMTP id
 a640c23a62f3a-c510e4fcb6cmr247621266b.45.1795008088363; Wed, 18 Nov 2026
 05:21:28 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 08:21:26 -0500
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAC_iWjLXfmSAgd0nSrXi-OzsKq0ZwRRwACmTUcT9uWEBRqcGbw@mail.gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
 <608bd6ca-5dec-4f2e-a17a-83bfd3608261@gmail.com>
 <CAC_iWjLXfmSAgd0nSrXi-OzsKq0ZwRRwACmTUcT9uWEBRqcGbw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 08:21:26 -0500
X-Gm-Features: AclHuK-n24jN_WXXtfcrDU67N7A5NEGxR1SRi66AlfLJWSwcjTVuqg0_dBkVZH4
Message-ID: <CAJnxHsgJNP_kMbVT6583uBd7aur2c5s+hSHd8YkOQQj3Jze20w@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] test: lib: add tests for the PE image checks
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Wed, 18 Nov 2026 at 15:00, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
> Is there a reason to open code this to create an image?
> For example, in lib/efi_loader/efi_image_loader.c we check the Magic
> and then decide if we are looking on a 32/64bit image.
> The headers into buf are in known offsets and we only really need to
> look into IMAGE_NT_HEADER32 + Magic.

No good one. The test follows the loader, which switches to
IMAGE_NT_HEADERS64 once it has seen the PE32+ Magic, but every field
the tests set except NumberOfRvaAndSizes sits at the same offset in
IMAGE_OPTIONAL_HEADER32 and IMAGE_OPTIONAL_HEADER64. So the image can
be built through IMAGE_NT_HEADERS32 alone: test_image_init() sets the
Magic, and for PE32+ only NumberOfRvaAndSizes and the start of the data
directories differ. struct test_image then shrinks to the NT header,
the data directories and the section table.

> > +/* Set a field of the optional header of a PE32 or a PE32+ image */
>
> This is obvious we don't need a comment. And we can probably remove it
> overall with what I mentioned above.

Agreed, opt_set() and its comment go with the above.

> I am not sure I understand this comment. You just need a buffer to
> store the image no? What size check is missing?

None with the series applied. It refers to running the tests without
patches 1-9: a test then reads past the end of its image, and since buf
is larger and zeroed there, most of them fail on the returned status
instead of faulting. The comment could simply read:

  /* Images are built at the start of buf, which is zeroed */

Should I send a v4 of this patch with these changes?

Thanks,
Ana
