Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C36C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C635980EE0;
	Sun, 27 Sep 2026 15:40:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pnawg7XTX3Ua; Sun, 27 Sep 2026 15:40:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 101C380E50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790523644;
	b=pez7GvB4MeG8Ayvs3Tf9yOHy3MwmkGuqwZUkmKGr8azFhO1pUHpusycM9YHHXFYQMPwt
	 GvCEWdevxBRddHn+oiIaz+1akpP71Atv5BfgcMNCP7ZA09V21zIle04G06ipX4r9pxV9J
	 mZ75YL58b8dtJ4b7WYWY73KBPp5CKA477WKSsn8/YxXIBZEjvh7vrQYcO/Qbrzn3wWb/i
	 bLo9rxn9HVdBXWV0LYgZV3Fj52AczIRsC8kL75sL3+Zj86ghBtMJlc6fqjzpwfIZuOUrZ
	 sIvLg3/BPfMnQtcnnPIhyuEP1swLEFNKJvDhLY6g7qGVZPgImSOgM8C2Kc8rTeWqqzg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790523644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BNCpKjVcVHXtexGIN0Cu4o8lrqO8Cj0JsYsvb7svS+w=;
	b=Jl+dVum5P63DWUehw/iwAxZvIXdrwvGJBTgo2OyQNwseZGqKAj7TjqhIG6/yKX6OlbTw
	 LMZ3Nn1fKwMbSwVvXafHxbiy+4SwygYJaA8x+1P6nC1OW/N/BC8h0pUrR0oPONWExTxqQ
	 6do1ZCA21eAJbae4eApxG9Klge+X2eXiY9wEFFbr/04CQqHpRmNqQm1YW3aSQBiOux5rC
	 Yq+NYRLI1BLHUYGqWjaudroGIIXfsGQiy0YxcRxABDaHELYcsLqwcYaBazpd8WLKNqPIq
	 kh2xv6Md/ayzwnKH2283WRXthlTMQZndYzxyyMzpmBICnObmn+y9aI/3h2LSmoe7vsQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790523644;
	bh=BNCpKjVcVHXtexGIN0Cu4o8lrqO8Cj0JsYsvb7svS+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mqV0r0FqprGA6UQv1Jbhlh4GAPZH/3SO9eFV86PsUO6B4X5qDqTTiia6MjRJYyL3W
	 Ynt8n620ghfY+NHolUQQcaNZPgh2GsIbvhqSY5jPl1L07w4psx+thwlIb2X5bdqIe1
	 qIjjM+07xpw9ec9LnwzfQzTWQjkuXOjZ1YoOkfV24L4dm1dlHRqxmePCTikTXd8ujU
	 breZA16ZMFm9/yuF4/P590IxEqt1cPePbebGxb7HDL84YUAdN1F2s7niW03/03JJUn
	 xYyRBHLr8uli8RXhIBQMTmt2vBylBgZq8C0CMAwM4pV2+hvpDIYhmOkg+mv+2pe5Ho
	 cYo7sl5Sf8v5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 101C380E50;
	Sun, 27 Sep 2026 15:40:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89B21194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F8B240759
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 81CDG6rhoe_2 for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7BF5440757
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790523641;
 b=msR1wQWGqzI78pzDJeSFUIPMyxD3B7124ZBRJc3OoGDv3GodwbfJMtGPsWhG4gYOdA8Z
 bNCFJf5XkB9h5WqSoovNQun+LL8KQE10jvt1fDoKB9SYBiyJ6vswHZf2E/MSfZ8WC2Xw4
 CoK/FPcNVK58Bl18UtqMAD0A3NbofWrIx5MP77r9ZuzQzGGyN3ptyHF1YOsqYsoZRiq76
 xiOe6I5iMgsKTY4LIrAZF2lQ5YiLS6h0kA9MDMjbv6l8mIt9dkWy+yNToDIVHeo3uuyJL
 YY9pwqAARNoU0six6hQ+DZpNiIX5dos9klOFYVkVOWg9BMmM8v2Gh1TeXnGHicipIFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790523641;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=BNCpKjVcVHXtexGIN0Cu4o8lrqO8Cj0JsYsvb7svS+w=;
 b=NJQBVvD5ntSVT4mZAAclwLtDu8Y7IpDSmLT8R7zA9uhYTmbdROqg7oRHFvfjS4paONIS
 gFVdimaOORvoqfWJuhca9VLKclIb+laUC3krimGR5GFPaYV6E/oYJeSXkLRPTXHrikgyT
 JF4YH9SHMMZS7Ohl+mMVHeziFrdje0/PythZtEN0rG3xEmKi+Qw3JkkU4AtLctaBlTN7J
 P07d4vl5HIyeI8HJl54UufLo9ia30/ZZpLHMvmmAvP/0vigUOJQHvhW0LBgwKqQdSh/ww
 WITLQXdAfZQCDIPXRHq0/DTRQ3Kh/Xq17U3fCUQxpdGR9de/uBC0clp4EIQmtGKq4+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PqshCwAW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::e;
 helo=mail-ej2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PqshCwAW
Received: from mail-ej2-x0e.google.com (mail-ej2-x0e.google.com
 [IPv6:2a00:1450:4864:34::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BF5440757
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:40 +0000 (UTC)
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2dbdcb4f59so134743366b.0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790523638; cv=none;
 d=google.com; s=arc-20260327;
 b=IcVnHws7j0ueO71rGuOcgzyHUEF3AbYxScy+lXWVZIF5qdCcXJAQHlMJ7AWtrQUYim
 9NvCeaRKufoMDiDHPB12yHEvcd+n32deM8Lv6qie8gjmp0bi7gYMF96/VnW76x71vMfk
 hAGZgyt6Qyg5wys80vpP9DW2EtirT3wU/Tu4y1x3tpDdjgwJj4DIzVRAEQhb7adoT1ik
 XFGGT85+WR7Py9wSLFlgbC4tJCmgxe0a2QKfX91x1sgR+hwwzE5rWJa+f2w8/1kaYdwC
 IBZ+fRJAgSp67v2/hyrPMjFC2w2n9ikpxIlowxUZJ+BFpd/EnpON9ctudXc03GoayeGs
 BAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BNCpKjVcVHXtexGIN0Cu4o8lrqO8Cj0JsYsvb7svS+w=;
 fh=e62jeGgiHNdRzojOTTLbfuqocSutGBjAzQlPfNYXnRA=;
 b=FSEwAMKjfhR0iRC97dTEE8oYuVA39SPoKuMbS6UTl16qrQmoXq00Tr1ihOYS8v//ef
 o9XrGPYbyZbtFbEcONAnKU0c8wRV9fL/de2rRRoFWyoHPPdXiw9q52SQ9esssT5yj5Lr
 srVmbumCe5WNHKkVsP7X08omLHZgwhsEzaM4Ooyk6Ld5bwym00JU3RZP6UOO8e+oFlD9
 I1ksFedbNUf7d/ObgVux+0/yIRBWO6bS1lqHBwGlpy/CgNOe32E5LiaQqDaIYjGuKkaw
 HlcDcNIORjs/smXm5Hg1aJcrYR0ykwu6ZV3lrQbW0Ye+FcvSIp1RbyW7v9/K0P3ZCO8U
 ZFoA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790523638; x=1791128438;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BNCpKjVcVHXtexGIN0Cu4o8lrqO8Cj0JsYsvb7svS+w=;
 b=PqshCwAWvuiG+ViLIyyqk0Ov4MBTS+VisR9kvQalB3tXWqbODSR70rDFNOYvfmnyU5
 oGQhhW806k3FtuL7/OOjU8fBpceG79+/EYi2QVjCA4+oSrIB/PUf3lGhXTtfw+w3nEnp
 81QZMJBLVBl6gZcyAiKNiS+cW6kJd1FEkb5JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523638; x=1791128438;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BNCpKjVcVHXtexGIN0Cu4o8lrqO8Cj0JsYsvb7svS+w=;
 b=0cBgdyAZqVAxTqhJW0H45I4gDvPLwo1UHIHvVG96GgwjXf7EDHnmXcpe+IDo3ruBqr
 VMp9QmZY08iissZkV98/G1NNdhkmkRMyzj9KTkoXtN4ynnVdnvUPtBDxZPpBb6gUZGyl
 R7btCi0K416UOHunOenHbMWvuJX8rURwRr3qd1ihY4f8gXwKSX6oH2BZgaBB8GFU5omk
 t7AV17udF19sPygHLnSG/RVP0eg50Po3p2n695N7DkkcEwU75l5g/J6rK8oj//nyBHtK
 94VKDhJEBpI1Yrt9mmh4DFSUyKaPVNDWVHNtpZCufnJY5KjqfQYBXbvueKwOAMw+Afna
 rIrw==
X-Forwarded-Encrypted: i=1;
 AKwUvByMIbt/7rULvfQbdnz2mZM1n+FXt6pYa+lULzyJdzoOv4yw3kg5tl1560rBQAoGhfRBSfv4nbM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kJhsbTMI/hCXYWYkq7s3lBEpeq5P1pwGmn9rDyN4qgOYZU91DP
 L03SzZNB17harIOfL0uWLKPT/zx3xMdQ7cRvNWMCSGVDyWg1+3rzIfBWfMHxQweOIOD6GrfNJTw
 ZfvUfp339cEH5vWhEfT3Nu1hV72qB5kkih1PYPkfO
X-Gm-Gg: AYBFou0/YKZY8FH4IHlSW2gRdxe/jdw6jN2/HaOBfhyzqaYhnrP3NsTEibz02qbLaiq
 1FrZmIWtQSE2aCYc5VC+ye1U7x0wAlqDML3LiaI1Tf+QWoWLsW8plLnRXbDn6VcnKMeT7gqIEVV
 GfjtgohvK6lrgTVUjb4KoQQiB7OBzTtjJcJUpuIBQMhDVQ1YAhMP2qzyx3jrcxh8VZeo86o/jXc
 6oWh651Uv8Zid46k777SAfiJuscIXnCxet/ijNC5xSmorYMWKnoXsvQGtwlSTo83gdvZwnG7mlQ
 G1HkrgcHMju9Tocz9mtx59IUCTBQ0sTrU18za9ueORHChfDhBDwGcg==
X-Received: by 2002:a17:907:6d25:b0:c26:1648:a06a with SMTP id
 a640c23a62f3a-c2ac25125aemr841574266b.37.1790523638612; Sun, 27 Sep 2026
 08:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260923213002.1070404-1-visitorckw@gmail.com>
 <20260923213002.1070404-5-visitorckw@gmail.com>
In-Reply-To: <20260923213002.1070404-5-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:40:22 -0600
X-Gm-Features: AclHuK8sh7TncGB4QamRUTl03qn4Z8tWu-hK3XttxQ2OIZamsvD1mGIx6R3Lzsc
Message-ID: <CAFLszTieUYWEcqmeUjReG4WvGWuOSZnuwUzaM7Y_bLoWQvnJAQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] doc: 9p: Add 9P filesystem documentation
To: visitorckw@gmail.com
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
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

On 2026-09-23T21:29:56, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> doc: 9p: Add 9P filesystem documentation
>
> Add documentation for 9P filesystem support, including configuration
> options, QEMU configuration, and basic usage examples.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> doc/usage/filesystems/9p.rst | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst          |  1 +
>  2 files changed, 56 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
