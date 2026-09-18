Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B11C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2238D812FF;
	Fri, 18 Sep 2026 20:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uO_fEaLzjtjr; Fri, 18 Sep 2026 20:41:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA170812EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764073;
	b=aKxUV5+RjQWNN31F6eYEHytn4Ryx6iY9u5xB63N/0br1j8IbH2nROZnbeF3KiNqTs5Y9
	 RgCtlSaS64C5dJ5McmYsMXYDpFTJgRpkSCQmSHNeODwJJW3mtId2Mmb8c5PeWnuJHUdZq
	 TFRXWOivgwvYD5cYqRqzKVfYzyMeNG5nsQD1LdbPdPvBK7IvOMLK6yYQ2llsUnqQ2Gtg5
	 Kfq6/G7S38JTafNkrlf/tYEkvo+z7KXfC6KGVH9VdFS5d7AH5MRlLjaikWg0eEVb3d9S8
	 oB3k9zxaYIPSGEOPTYyHPu64gfYyj4Uh4ES1SsUxAkQayqlmZsT0d9EeN+JRsvFY+Uw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E0Mc5qqjU0lrSpV80g/rkky1gYiBajwrSVkNy5Livp4=;
	b=lxFLj6wTP1MoCQpFZzR2YQ6HkGf+xwBcelSzRWF8HbVxh04bRI2qyDD/Knf/T9xBgQzC
	 IlPu0fBCr11fN639zdIM66HL1a37M76ZKa11u5bAXoQmg+UYdC6RoMr9DEFbpzcwWQy2c
	 BuuMU61u9b2aapTGkmRVadtIOJRNnUWMB/MWZqqTNOl8S3sNeR1bcUjkk2mbYlAeoffH4
	 nV+xVQfXbzbH/LpqSicH9oGZ0O7blmhK1CzURve52VFTky0QOllkJ8Bx7vfHB31N6hybi
	 ZboY4b6M0nuHYetoksxZI/zOpRtsu+qK7z+cKlET2jdKWe9cYwDMTkrsCNlDJaJfCQQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764072;
	bh=E0Mc5qqjU0lrSpV80g/rkky1gYiBajwrSVkNy5Livp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xX9tEJyHLHQ7zXjVyoenKcS/cfUwYDe29d32oRR62+SRtGXyORBSzehkSaulG80DS
	 P+inPhvXjWPSzTdkUGI+oGy9ZEFE1n7oWyvjjr4f91KH51PuDZ8JMNjySgT+PuQEL5
	 8c597VAcQYF6TdKnKoYoY5/QAdPynesvsEM2iO6PKD12/a+PsBPOPC9n4XycjjmyPY
	 W+rHZ3mle36zyiBtZHy15xtwq5EmIt//3tNj5p14yYyAFI3QiOx9UTT50HKo6zE88d
	 OnN5D4x+Koh0nWe2WeJM3UPAansZ9aqwqIwQD3Maff7rm+z8oeoK8WMmaRr7E5y9a0
	 Wv2iWVajE6w8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA170812EE;
	Fri, 18 Sep 2026 20:41:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E43B913D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAED24006F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KoDA4d6S8BMu for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BA60E40022
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764070;
 b=K7eOiCrg8Qbs6gnKs1PwipBQBNs3XeGSvAmblVYHiwSE/wk19qo9IcUjmvGXJMv9UsIz
 9EiOOwNkYZCw9mr6I7vo3f12qzn3OpsH7IfvroS/O59swidNMb2aeMBoCRfkdZ4Wq0UO+
 97IzfTA5bhuLozLs29b40/aZ8Q5xfdNaHYGYE7VbGoEmjA8k0FlxtuxoxoPOio0sKd1dp
 hJfOsvLnf406WCAd4MIJ9MAJORpYEaP6TlFO3vbnXw5R4UurFk/J+YTvOcsVsClXuVh0o
 XisecmoD2Fr9hmwQze+LdZRdJ+0ivZVAAzljF3mn5AZV1hNCu4tYCUAxboosLvzHiIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764070;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=E0Mc5qqjU0lrSpV80g/rkky1gYiBajwrSVkNy5Livp4=;
 b=PU1CSkU3cBlNtZx60zHy2Y6vx6enfFsLjJs1ZDdyN/2TPaexyyGkOylDyfe8NY0K6KHN
 QS8HLNpWi6cb/FRBJq+XS4Kv+ZODLo9A7KrIKaQZxLIsSOlyHD9HXhxzIJ8zyvCxRtC9l
 3gB1rVXRCnH5L+Nh71iKkzVwBFz8foKNPkTqpMAgWHqKyX6uxHW6J9CmBSeyABhlZGrDf
 KvzwnLXvcjyj+kEG600oloDoZO1qzc7fYEz2qHlTEILINjZoRGFryCzk3pbmJqRdkEenB
 mb+0TEI8wOmyeKl/oTvlRhzSz8gxUOOL0q2LXipOBXBMolIcZ5a3Kp5uyPchEC9ogRA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f0kkM5Tt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2a; helo=mail-ed2-x2a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=f0kkM5Tt
Received: from mail-ed2-x2a.google.com (mail-ed2-x2a.google.com
 [IPv6:2a00:1450:4864:33::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA60E40022
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:41:09 +0000 (UTC)
Received: by mail-ed2-x2a.google.com with SMTP id
 4fb4d7f45d1cf-6aa06e51bc3so1977603a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764067; cv=none;
 d=google.com; s=arc-20260327;
 b=enhyb682NchjhWpYB3YIdVUK1pho9yLdMa1P1inkwF1WrHHOKCzV1zaoTm2AP68CbE
 Xn9vdRMV9+z+Pcj9f+G/uUcJys+w15Za9uiMuuPjcU0PgOuL1Eup6JnBCOuR2VxRCqUl
 fkD8NDUuIH84qGU/3dKv90YXJs6HkA6sK0OGywbt2c8q2TBcHhF05AWMupgh84MztpYh
 gUprn0ROvz8uynm6iI799lt5YKC/0E/Ry1S/zEJgFKT28MtG0yhzq/0yiStOizzM5CQ5
 KKy4PSpTrJWOSc9fltpFma0CMJTb3xDhPODP2QZO/fJFIxVPvKk3NktEMCaXEAdkB/F2
 /TnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E0Mc5qqjU0lrSpV80g/rkky1gYiBajwrSVkNy5Livp4=;
 fh=hMnzCCESv5iutVaH6AX1PrbYoVsPb+wpOEI00M227js=;
 b=SrT1s9W2+qm/3mGOaGF92FIGfHSDcGjjUXFZOuiX6BLLVejWIjMNBemaQ2wyjV4zmb
 n/QhX8WgtMUnTWBbQHc8XnB0HvYHBlZC0EVxJyN13wQBdRO9yPcj5zoXFKTJQ/FhSza+
 r+ncgWTAJkZWNCk8aujvbG8uk11MJBUJNWoKphOIpTFdNEMaFYIucUEdZbhDf8LuC1dw
 vFS5J7+KLlB9WfmEVMJn4bWIb+tBouxwCjcMjz0KhISO4RFB1w+D+MeDvnmvwyMneXby
 12vDGd54LfegkPVKNPERpcDZd6MAi8r4X23WG6O7/sr4lny26AG0Ci56MWNLpRtw/aKr
 88lw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764067; x=1790368867;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E0Mc5qqjU0lrSpV80g/rkky1gYiBajwrSVkNy5Livp4=;
 b=f0kkM5TtAk8/22+xlQ1bvaZd5m90V4KAAyAYHpuYHUvR/s6DBSfT3gQSt8gHtbSZyI
 lx4zFMUGXNPgH9TrU0xjsxjxuvRuQyTEJ4g90EEyAuW5iqYNUsb6+sBZOXFJtMQf9gNj
 ftDsBOgIBlH1+fI5Xxuy8BGLu/J9lSJSUaICM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764067; x=1790368867;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E0Mc5qqjU0lrSpV80g/rkky1gYiBajwrSVkNy5Livp4=;
 b=SraoMFXPoomP5qMQnihmEez62Bs+VaKJY7e3y+y8J6Fc0mOsncg/cFGhI1o7jqqMeV
 H02xT5CIKjZYLmk0fDUotEoUjxzPT5PzT4I5dOwd+M7x/Btwa4r4+SKbhsj/zGoNTf6Q
 7t1/+eUTjF82Nm3DblfA7zLZSoGAaSzTAifnSORofUSiyFvYk25m9/kmGw75Hibpzu82
 sVvpSMRPh1QjLoBSm7tjtHN4nOP/80bmSpjm84DENSL6ZHDH/IE2/VVHm4O9Fa64TXK3
 TgWIt+0aaRMToU98cJxAiVIo3RZS8DMZYFoUj1ofh07sZ8scFws8F5+naebMxfQo1bEg
 pYqQ==
X-Gm-Message-State: AFuF++kr7WcY+C8Mm+rdJa6IpF+tcnm2YhfK28XECaLsffQrWjdZHsE/
 ZTNe1DCBWQrqrVvJonZElrJvhRoJZratLyt/mLud6OPxQ01W4eHfdJYyaAHGzRQ4/LA1DUTKWNW
 Q1lKDSCoUlPJskqJ19vJ6Y0ciCKt4pkkJA9gWJROz
X-Gm-Gg: AYBFou3q9cpOxW3eoR4cwCJAsFkqQEcrnLoLiEZh+kIm0gSqLEPoR6qq+ZWXTDmmOPm
 GZZ0FsPyBxs3BbALTI8VHcL1xWpRQ0zLKllD9YBpdhb7/fU9Wa8qTm+ZNmm6BgW9yDz2Zwaui78
 QBp8W55SUnzP26zrMzGZ0uf6bofwLzdJEevptpgVYEg342zg6/i3vhadwhS/mG0PotkKFXiIPoR
 4qjkqD4im0KYlAZRMSuBGp5ck5XxlywucDQjL7ZDJM5Q0Kwca9VWvTDxFc9+dn1sAEhVXIi3k5g
 UoJdOaz/ncORQ80ApOsIQgNIzU01qGXWEPJLirTkQLlJ4yITlrx5L5Bb
X-Received: by 2002:a05:6402:5006:b0:6a7:f6cd:b402 with SMTP id
 4fb4d7f45d1cf-6aa5686c505mr2528118a12.20.1789764067393; Fri, 18 Sep 2026
 13:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260912124454.13578-6-aristo.chen@canonical.com>
In-Reply-To: <20260912124454.13578-6-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:40:55 -0500
X-Gm-Features: AcwNN1U7LKEtAhN1nmeQKHHobKJq6VET5e4cR4JGf0UR_t34cwh39-aGBXcVOCw
Message-ID: <CAFLszThNfO9fTya4O8eU+bdma3bjTwGTjWmkEG52POyYK3baJQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] test: py: add tests for the FIT image-data property
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>
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

On 2026-09-12T12:44:46, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: py: add tests for the FIT image-data property
>
> Cover mkimage's resolution of image-data references between images. The
> positive tests check that an inline FIT carries identical data and hash
> values on the sharer and the target while their own properties remain
> independent, that external data mode points both nodes at a single copy
> of the payload, that a resolved FIT can be re-processed with -F
> including conversion to external data, and that two nodes with
> identical cipher settings share the same ciphertext both inline and
> external, whether the IV comes from an iv-name-hint or from an explicit
> iv that is honored and retained in the FIT.
>
> The negative tests check that mkimage rejects references to undefined
> images, chained references, data that disagrees with the target,
> image-data combined with external data properties, a configuration
> whose image-data sharers have overlapping load regions, sharing where
> only one node is encrypted, and encrypted sharing where the nodes
> disagree on the IV, through different iv-name-hints, different explicit
> ivs or no shared IV source at all.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit_image_data.py | 373 +++++++++++++++++++++++++++++++++++
>  1 file changed, 373 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
