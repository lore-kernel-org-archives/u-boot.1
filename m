Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AB8CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1318D80845;
	Mon, 28 Sep 2026 22:42:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jixDDKJMkCvd; Mon, 28 Sep 2026 22:42:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 53214807E1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635335;
	b=blUODeN4hND1lxJyBevirDF/JEs7vLIIHFjMKffWKN3l3Qq9Jd1nuPxypzFXGZDf2Ysu
	 0ux7X+uUwd2v75SXagoaDBQ3ZvvPT1KM5mG9SnHHDFa+qkNy2Y1+mdOSxgaQeX4s9CO56
	 vjEnhLpid1vVX1LAMCw0LG72F0UnNq89TvuC27khvzB9ZfmTjbjWUONkrQWwDld79ZbJK
	 L/NDfgZi4+6humrOu9ivCBnaqG3JwtcZiJbttLszPdd/eDPnITlVfWtyWGeXzVFcEs3o8
	 xUvkr6Dique+WfNl0WpeDnzfob9klmNy1Ba8QhCyK5yIqGe1qhZl0DOt8rYMqkvmkiw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q5WyGDEB5f7kqSucWDXBxis2SW3VOAz2JOEkJMyMTGQ=;
	b=bxTBTSZWQC+qOQ3o64l8zFXwqMOmJvCIfcina7Yi5yYTma67mzGPGOfy/LUa9g6O2Cix
	 sp6FCzFUia3ZFLHyNecOUUYNny4v+iTsFq+orJLge9fqzDVhA/o+g4wsxT9/zctYqPjxF
	 PArJ/cHsMTQixFVF4peOMprhtow7PuWFszcnU91lw1bwdifmrMavXAeGxxN9GZjFo30Sc
	 O2jFYLlaKSOh1ekd+eWqVibIhHY3yYiOoEnp/BnkzwAx2f+vDjs8tXJobqjYCc01c9lyR
	 IIyh62gWZaX9qarRR0rr76WERikNSSqkl40N1X2GCmhWYUN9tfxl082Q7Q8wc46D9Ig==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635335;
	bh=q5WyGDEB5f7kqSucWDXBxis2SW3VOAz2JOEkJMyMTGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsqMNXx8Ksa/LtYilxWVbr07DjM6U3OupGNbniD69txmFO48iLLy9lXVNUmpea22J
	 2n4JOmqnfGekTkJkhVtkBSuYfRF7Mh8Fua2rj0UR51O4o7OWVKz4wXV/a0U7lnIh54
	 31fc7Ijs7CuNNspCji9sc57wSsO1A8Wy5d2RmmQHBEHvNWy6Dsqu9ojorUMnO00WIV
	 RmgEDfzXNMb96oCJzty4at6Cb+IopUSwypj1GonUqHYImqz6MyjhGAeXa5qcrKI41f
	 gPH5b3HhIB/lHgEoY3+PcUY7G8ZxykCDRz1w8Q+SnNVdD5UlvEeyt2Z9/QsUxaMsnd
	 LGi6m4e1e2cLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53214807E1;
	Mon, 28 Sep 2026 22:42:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C62661
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51EEF40509
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6NeZk6reoc8 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:42:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 927C640508
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635332;
 b=cUcnjQ1y9XtLU+OTzoYA6d7Fj1ZaK0S5MtzWI2k17508ofM3973eMEtonVZwnTji4pSN
 ZQmWLGhpMTGx1whFMKQML4cwbATOWQv33Oh1g/bxdCIwvHmakt3lR20TDP01xeNqW0aWd
 7bH3oqOS+5LVCfR91aqWSNtK7AB0owG+M/GvE44zOq3B9edO0q9KCiA8QG/XOF6DI1x0F
 79e6EG1Tt5pPnO09TjIfYsGNLe0mJX0syraeZxuFim84yqaGRAa7fKe2sp1OV2uxLVpNi
 Wn3F8ESHnNyCG4w2J+jbEGy4cM3uUo7C5kfVtxQitN8W+I7YFVN61RL/tRgA/phoHeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635332;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=q5WyGDEB5f7kqSucWDXBxis2SW3VOAz2JOEkJMyMTGQ=;
 b=U9eFEI0tTdTL25HApEPWS8EZZJupfKHsSo9cXBIbwizCH0ES1l0tJzBGrmDBVg2IqVY0
 pmrV01kYZgMDYqWdScUXqtNMzvcY/B5Ronk5HmVqMJ1FPr6g+OtB0Zlxlsnpc/io+8kCW
 E8Nicz76bw2qH2J+dy5yVYPy3CukmRgD13fPyiVz6EldIW9b5mgQwf5uSTufk3fVzM3K8
 kDG5Bo2QXcbYwuelxO+/FkfPXnp6pNbZdr5tNMHMQjIvDSD3RfchvOUxQpLV5Vdcad8uW
 9s1W994rZ59tc80s6xYnqKmvr2cMbK0bkp4l4+zMsp5pTv/EFeD+o9TVMl9Hd+b/hwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KDWAW8SF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::e;
 helo=mail-pj2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KDWAW8SF
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com
 [IPv6:2607:f8b0:4864:39::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 927C640508
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:11 +0000 (UTC)
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2df4aa80a73so21445665ad.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790635331; cv=none;
 d=google.com; s=arc-20260327;
 b=T54PZl+7cqp0+l6lnaxEnoyU/wLhc/YAqSN9L57vKbci/j0STqArfpqZeZkhcAIkDq
 QAyiReq3EY11DiTReNEmTLg8E/5qe7SjKpHy3GuM0g8ZOPIS8mky+JBzOKV3cAv2Up0w
 k/kG7HVHx/bZr62NLNkf3syCJifaP/KWspkc+wet473yE6DzBQnJ0Z3hr8iv4rgb2P/K
 GQiJnItdPQ9jdWny4fKiKnWwVpLiVfgDTt8K6v7RRoru/ywJR5TGrB0g/cu1xGh1Hupb
 RbJ32D0SPwcJ1gyVCF3eQ5Y/UiZ+oAqqWFQ7xgqUOXRDG6yRx8HgQ+noL6qmOxtK9hTN
 I4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q5WyGDEB5f7kqSucWDXBxis2SW3VOAz2JOEkJMyMTGQ=;
 fh=CenhgO4nCyFC8UARHX2bAG+GrkjE4uLx56YjZntlO6E=;
 b=SSB3qCBv/b7fQJFB52m7ehcQDQHFv0jK6HY6PJnT91px8s3ae+J7TVLpd+15HM6Shd
 S/bjO6ohOeETOsV42mQXb79awFmO18mUnSAq3konO4UuyDvcMDu/NKnnWujQBFOWTME2
 yiqYT22KTvXAPn0/ASLdF+TnDyPWqMkfmdNf3u5y/h0jDrXJqOp5V2f7wGh+iaTD9NQR
 cOyF/MIHXhLf5JP2QtDFxRFpcF4Tm+70Gb3QPX9nzrEW2WH2TOQq/dRP5EKlKcmizP58
 6t2JiKZR/2iG8y8DCpNftf6Te3qVb/9jU+55y8oXxNn5mhbA4eAhQWEIRNwaugffXb7q
 pydw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790635331; x=1791240131;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q5WyGDEB5f7kqSucWDXBxis2SW3VOAz2JOEkJMyMTGQ=;
 b=KDWAW8SFv1O7LatUW/P+/0efUm+CqaQuI2qnmm/pESm+ljx0BJ0UU1Yg0Yxb9bcoU4
 CKsRVa4nsoi3gqnZT+q+AY3tNsWaKO/QvsBGzz26sHKPBAbfwW2ADGonj8nnzb5Iwu4s
 TI5yXzcSqz/q7XvOcU9Y7QpWMGtS5jMv1pd/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635331; x=1791240131;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q5WyGDEB5f7kqSucWDXBxis2SW3VOAz2JOEkJMyMTGQ=;
 b=HBKvo4TCBSf1NDX1FSLlqF7Sj8smp00mDzOOr74DEE4xJqAs3IkHIqdJaCO6bZv+ds
 gaW/tIPgs4xhMBGRO9laqo23XT8Nkse4shCwVrBYOa8k0wmWeQRocw+fWzC76QXU/9OI
 QxIQ/9PIziRrgJaxRZ5ZDOAJavbIIG2dWvkjtR7stZcQLuZcB7xwHtvmQG5/XPy50H0v
 EuxjXxHAWNp0hZru8TH2A9FW1+VwVCUbfngLmc/pIQqQd/BuL8ZWf0nXI8J0EIstNjaX
 V+ckhoj8w5NKvuIT+UIcWFCIcllw4d4xP+hikExPnkH2602RbxqrRoheoc5wjzvh/lo8
 wICA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzD+YM8mMAgxHqap+70C3teL4VGgv+XrJ1s7RrwKVB8hd3Gh3L2vvcEe1Z1640qpCzrOo/72jE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIwIlBs0FaLLgDoQAoi+SGv/szTf/fXYBuRBjG0Rm6uEr5TY0i2
 YTzRwVlgdJkcaCUCxv7x+oXfIqeCe43GZ1MeuO680tOY7d3IEVHG/Ox89KhdTalSEaSnDNWTeJR
 y78oUIcjPBcXCaZSLgSxHhtRHWO6YiJezic1NsdHjhHHA03Hf2aR6Rw==
X-Gm-Gg: AYBFou3TWujYXSyeLIigQm1YslVXmYbls8MuAsU8h4Mm62cQ67K2Eje9KvzItbHVrWp
 OEYXNNxXBj2n+D1+LFUiJn4ZXjnMePpY7J9Pn0evcnsDiqKqBxZHQSTSRIOVZZ/WFD+MCt9Dxtj
 TT2YccnCkYgGCpIobyugFTEOQxpy8l1tynZ2O4zDCQLmOivCZXBJy6eZmhUqksGmwkoM/SfDrEc
 rFb5YyWcOcr5fhli3NIp20cRUq4WQxJ6GxFScXumj86j0vU1yrhEcCLI0Y8bK2jUeUlTewnP1FB
 30vrkksWNDaA21fIAHmwbTtOxv09BpRgcL+PDaIRmdANhULnt8VPyMq4jw==
X-Received: by 2002:a17:903:370b:b0:2e1:530b:d890 with SMTP id
 d9443c01a7336-2e1530be1afmr35841755ad.5.1790635330552; Mon, 28 Sep 2026
 15:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-7-sumit.dhami@oss.qualcomm.com>
In-Reply-To: <20260928064041.1432227-7-sumit.dhami@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:41:37 -0600
X-Gm-Features: AclHuK_zq_dwPgQRbgAY4x0oFs4kwusAxhFQC4MQm4slgKqUZQmEThAb2TiIYwQ
Message-ID: <CAFLszTgw1=J3pJg46gEc1Wc0GcHQ2yvnbRz3HNZbGEgdDJZ2+A@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] doc: gpt: document 'attrs' key and
 gpt_partition_attrs var
To: sumit.dhami@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com, jbx6244@gmail.com, 
 vandhiadevan.karunamoorthy@oss.qualcomm.com, 
 dario.binacchi@amarulasolutions.com, sjg@chromium.org, pbrobinson@gmail.com, 
 quentin.schulz@cherry.de, varadarajan.narayanan@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
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

Hi Sumit,

On 2026-09-28T06:40:33, Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com> wrote:
> doc: gpt: document 'attrs' key and gpt_partition_attrs var
>
> Document the 'attrs=<VALUE>' key of the 'gpt write' partition list in
> doc/README.gpt and doc/usage/cmd/gpt.rst. Document the
> gpt_partition_attrs variable set by 'gpt setenv'. Update the example
> partition list and output to show 'attrs=' usage.

Documentation normally goes in the same patch as the feature it
describes, so the attrs= parts belong in patch 4 and the
gpt_partition_attrs parts in patch 5. That keeps each patch
self-contained. What do you think?

>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
>
> doc/README.gpt        | 11 +++++++++++
>  doc/usage/cmd/gpt.rst | 11 ++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)

> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> @@ -56,6 +56,7 @@ partition string
> +    * attrs=<VALUE> - The GPT partition attributes, optional if CONFIG_PARTITION_ATTR=y is enabled

Not quite. The uuid line says "optional if ..." because the uuid
becomes optional when CONFIG_RANDOM_UUID is enabled. Here attrs is
always optional but only does anything with CONFIG_PARTITION_ATTR, so
it should follow the type line instead, e.g. "The full 64-bit GPT
partition attributes, requires CONFIG_PARTITION_ATTR=y". It is also
worth mentioning here (as README.gpt does) that the bootable flag is
still ORed in on top of whatever value is given, since that is easy to
trip over.

Regards,
Simon
