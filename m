Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B06606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HiZuEGVz;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=d+sF89Os
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0285C40A66;
	Sat, 24 Oct 2026 06:41:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qMoTx3qCwXp; Sat, 24 Oct 2026 06:41:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F81E40AB2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824099;
	b=TApDL3Ng6P1thjKO0zMXpn5jbiUdWWvf40ecI5RuYJdX2/yOgMLBkwYYooF1jm2BRxJL
	 Kkj/VgjytnF8l9fi1TNd6GGfthKa+/KqWgVpraz10gp9oi0dr1YlzLKJQ9DLus9s0cccG
	 t8MQr1Xq4fuKb/+jEhRJxMWBsLgNFiY5y7xndFkF+CTLEag9h3JdkcXtY96uwl1R0wjW+
	 f3YkdDmskIdDRlVcaGou2ap5EiwQg0UtT8ZxBILSaP+d83fJl5lgMZueg6s4TXsmCjOdr
	 jZYWKLtGMGh20IF0TwVt/LYyBQExZZOByKTYGE1tf/YVAaLFjQRxFlyZL8h/ODC1InA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792824099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FaAFyB1vK/PO1XL3HsYvJYlri81ejdncYeuZ+lg7Dik=;
	b=Y+PxBL6N3tGF3Z1JAjOyfnCnM2NLGydK/LZif8sbikpeypMurMrbX6BXy9euBxad0Nbp
	 UNyRDnDtlAMz01WFrC7CzUa/h1uuj+ik9jziF/4tbnhzvw+64cHA52PEq4lzxgM4AGV3v
	 fkkeua0HzFeXEhLDxph8QoUB8juVlceP+qGVVp6Uq7KWw234qUItTInurMMHEXgqtBaNA
	 FGleck0uidOIiwKYxmlr0fs+PXYY8J4UiNV+HHRb9D6fdDUX8HFk63GwVc+05yKfrJQaC
	 9dKrXHD0OBbhSqMbQRTcSpVlXJeksPo7B5fHhooRkka/OQpaMwpytrYKH8bWTItjwIA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792824099;
	bh=FaAFyB1vK/PO1XL3HsYvJYlri81ejdncYeuZ+lg7Dik=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HiZuEGVzklbFiqu6mHEET0qhOfjDwDuoXXpjWQc4Q4LgHql7jtMJ7mSK0DB9xC6ex
	 PHMk3jygRj7msPXXzpV0ak5+syE4qiEmsB+dWzoWR0+tjoJ6kg5tqmFwQ0KRVHLeqU
	 eiFBmC+DbJ0ARAYYS7q5LeVRURmaay2Wj4B9JiOsoz5ezHnNG36EavkmiuHXo/JAzZ
	 o/4UUZLCES/EwHJCriEmbAD7C6vv/+14QExK0h+o2YAFNCBdqZpME56E/QT7ojT43C
	 3ewynSmq0l/UF4ZqqGGwo1ZHVZfJCbStBcUm6pjgwdG7R0SZhdOhctS2kxwp907C20
	 CPGoI2JYHZ6uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F81E40AB2;
	Sat, 24 Oct 2026 06:41:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E06C5235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C68A360A66
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id muLrKsM_SPB6 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:41:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E5BA60A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824097;
 b=Wqz2KbyLeCPygjID8jT++Ydd9pXUSSqM8tiXBE8npAesirc4oDavQx8WsrHdAkS/jYsC
 utHG8rIKbhQjl/IJFhO3yehroLlEI3gLVgPp0Tz0aoUrofFIHIZP3SCmnqOomW+ZdZN3N
 w2ajfmpcCkKYbIBFVh/7jIsgp17zXI3A0IRUrEeh4MgXYt7Vu7RPiLjoPa9omRipzqSSX
 gXdVtTq19IM6cwR/EiNwqOAZ8S4UHdnPgg8LiJ5h7iD4wxXbvxcUCcxoV4PCvXM4qpAPP
 WjCwo73yRsKPIGzfq3Hj1E9I1Wr8NURXv26EjovyG8GwdWZ2qvJkBsEWjT87S9KiGXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792824097;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=FaAFyB1vK/PO1XL3HsYvJYlri81ejdncYeuZ+lg7Dik=;
 b=Iq2LmwtUMC/ZDzQ6cg9me3cmCU+5dO/mgmvfkXGl/yjatuWDuAqnHggE2pVSTAXYev2W
 /VB+WPcD/IcpCRnezZiUtFcSoLtRbycKmnM/22XoC+9LNIA+cxl40YMX4SLbfs1lM2Zwi
 y1W43bEaKJzyEEuYDyV93UjT+nbXLwx8FLI8k3C3kd73HhvhuJ0bBmYelcj8pVSwaPOmQ
 haMMgqvOnGYBSrUli7ierKc3CjbPYHKd55yNdofQ7jgIg2tb4ICFrEHlWQO35MmKFLxfd
 4RDir8DmUGBWFFKHUeRW9K3zVG1Noq6JQ44kLzxpMID5MhqFKAptH5B9ywbyO+1fiCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=d+sF89Os; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=d+sF89Os
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E5BA60A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:36 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e9995ce866so13301405ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792824096; cv=none;
 d=google.com; s=arc-20260327;
 b=sEw5ieRIuUfFRbBJTBKunY2QdCNlGbGnSL68fRozPm3ooOrqbmcPH5AGTtPYWXhsey
 U+jt8nbYe7kZsr5B5Mb6RJsfwe28grvzWQ23FTVGCB8v+G9LKUYlEyGMsCvoLrbH0qy3
 +R5q5y8Nc4luif7YncfSTvw/94SIITgvTlfo9q3gb+PmTj0sDoYT/M2pY4mS7WU9Xl9R
 E276FShNjP3tsOD78jYoXk53+zFm4CEc9Iq+dm3r3tclBoHZA1VuOnx0O1++DcVPyzSc
 REIRfR3MYYDvyqm27J9amCSYL7vcE9MFMdWJzw+d8GvBwauJiMOutUMAywnzzmsh/p6U
 a8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=FaAFyB1vK/PO1XL3HsYvJYlri81ejdncYeuZ+lg7Dik=;
 fh=L/uw9+u71ZiDOqmjlybLnHPNPB0oTVqkdjWVKnRfXQE=;
 b=Af/Fik5kbWlAoxftbreB/eGSZSNSUrVEkPMdrTkUQfauOdBHb2XIo8a4veFr6q5rZa
 VE5oQeXmoGxYGEnpzB3vskd7UDT7eyhBTLnrbkEMfuTNfpKTQaOOBkNr4IP3LGXC7PDP
 ftfEJH0TFefO1tuNFaX7jdyBTH+weDF1ZWc1Jd9sAVcz2578MrmQTQ8EAdlB0vt8E1dl
 3DLSZ0BcgmdoH9bLC1LWANxHR3pTEOnuAFosqjUycjtNRzWkKUt1cO7q4XvkkMqeHg3R
 m6ntyyqwUszPWc2mO4OmyNxNflmPeXq4wPzPylHn6MmbTn/0nrvUKPHZEZSzd7MjkUVH
 tilQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792824096; x=1793428896;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FaAFyB1vK/PO1XL3HsYvJYlri81ejdncYeuZ+lg7Dik=;
 b=d+sF89OswueQsLN28MYRZVGmSZwlw6itP/r0kr3vekAEJC8P1Cj2eHzf2e2j06QRBl
 f4GiChRhShVL52IhWj4t9SHOpiP4xtGqLuJEuOvH1/peGl3Uu7gb+CMXEC534yaf9rNA
 WuCQw82uxyR4tfQ0ElxPTQZFbcozs3zU8QTzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792824096; x=1793428896;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FaAFyB1vK/PO1XL3HsYvJYlri81ejdncYeuZ+lg7Dik=;
 b=zoQSLlHNtCZ3PrBhCUlT5VHNjOkLkYZZb/DQIlVloqXDOo75USkB16mzvi4uHLhWpE
 tIS9LV0701is8qBLNGC77bm0EZTzL3Ec29rQEW708N4sqd2PnnCwDkhaxJ7is16JM3kY
 dxxNaXpabN3oAGd6bhA/w2U9TPixxZtY/8xc5e5wfvY3hRRzLPFQ5l7w+1QM6JcMmvhG
 PzCsBck7Re6ar4/RPMkcJyy4xBLf7SfPc8ZxMTMKZt5AqR7/h3u1GFPFJWiCeJZPeeiy
 Qzwsv3uw68Vn+jzgIlxDLGU6oyOq0IaPuHFF9rMhBHD7q8W5reIXfST+6Iaej3eluBo7
 Jrhg==
X-Gm-Message-State: AFq9FYJT3MXl4/5uxk/za98vrGkf9D3KaHYCjNwXq2np9uyKQcSq4AwW
 mb09//eCnzpG+h2e2VnmVrUuqf0/6lEU6K0eRQ2NIr4fDBi8DvWDCUB40HX4wCVur3uTpmR4496
 VMaLPlhW16N8vyTLj93LLeWcyI9QcFniufiCIyx8RGKdALm40CTFdEQ==
X-Gm-Gg: AYBFou2KbLK0zzAajkJbnfm3QWMc74sN0tldcGhDEY1Bkyh4ug8E3uWERgyII0sMf6L
 p34+VkrmT1jomaa/xCg4quHsjn7WxmZmUSphEY2MZCZQ0F8VDO4KGiVLGFdGmmsxpvHWXbzLB89
 XBW4+bP//kHu6TstoYRCo7YDjeDW4BKIRPLk4f9nVkSIo0WVlp/vBQW0Wey1rCpaaxYbqHue10m
 zXbAd8w1BdIY3rxF+SPheWEfbwUQHDD5a18hit20/orrR6cdVMTXbpupjlN5Rs9ADL+nmnE4skh
 HxVrvIavnTHEHOZ4WSAXjqQGy0Q6PTMZI4zWk54LnqJ1Y9R+az+/qAs/61qTvfaIMo0T/rUU23w
 CzdArGpD25aSELFmlaiBYObm3Id78nUC33dA=
X-Received: by 2002:a17:90b:1b04:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3adeae8b8e9mr1171959a91.31.1792824096031; Fri, 23 Oct 2026
 23:41:36 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:41:33 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:57:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022135740.3869144-2-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
 <20261022135740.3869144-2-padmarao.begari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:41:33 -0700
X-Gm-Features: AclHuK__nn396ptiJAG4qw5_hs7aS02JUCNuhQy7bW6fbZ3lYY9K7sPhNDryC3Q
Message-ID: <CAFLszTiVXYwsCJQqyxEL2x8MS2NTJ8jqtUphUjB6+m4jYYqmDQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mtd: Move struct mtd_concat definition to header file
To: padmarao.begari@amd.com
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Padmarao,

On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:
> mtd: Move struct mtd_concat definition to header file
>
> Move the struct mtd_concat definition from mtdconcat.c to
> include/linux/mtd/concat.h, so that code outside the mtdconcat driver,
> such as the upcoming virtual concat support, can access it.
>
> Co-developed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>
>  drivers/mtd/mtdconcat.c    | 15 +--------------
>  include/linux/mtd/concat.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)

> diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
> @@ -9,6 +9,19 @@
> +/*
> + * Our storage structure:
> + * Subdev points to an array of pointers to struct mtd_info objects
> + * which is allocated along with this structure
> + */
> +struct mtd_concat {
> +	struct mtd_info mtd;
> +	int num_subdev;
> +	struct mtd_info **subdev;
> +};

Now that this is in a public header, please can you make the comment a
proper kernel-doc comment for the struct and its members? 'Our storage
structure' only makes sense inside mtdconcat.c. Please also say that
'mtd' must stay the first member, since callers cast a struct mtd_info
* straight to this struct.

It would also be worth moving the CONCAT() macro from mtdconcat.c into
this header (or replacing it with a container_of() helper). The next
patch open-codes '(struct mtd_concat *)item->mtd' in four places in
mtd_virt_concat.c, so a shared helper would tidy that up. What do you
think?

Regards,
Simon
