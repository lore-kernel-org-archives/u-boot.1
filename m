Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672A606A338
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Eb0Dcy6D;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YhLffx/E
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7914081253;
	Wed, 18 Nov 2026 15:27:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MeOlGhLRgojj; Wed, 18 Nov 2026 15:27:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 88EDA81230
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795015656;
	b=pk1URN5ICzjxnySR0Xjcg1ZN/a3VaRKN7AyaCLi7nihShMJ19kVU5CN0k7PL6B2KDK3U
	 WvbBFDCv34gbjeR14RL1NaPpXTklmBKA1v9CnQpPUgT9Hp2xb7J8Donunz30/+J7hGBgv
	 atVlITtldv6vy/Cty03HBGiaOPrEQZkwDstSZIJC2uhXmC+2Rm0v7lbmHGpy5b5Z45ZGq
	 LqvdUMvLf7Apg8Ays0psxCg3sQ4Iq3ENii1Hu/TWocFpyFnn5aN6fvIJwaRDvS90lH4wL
	 HYwTK8d9amXDQ78H3bIgfXdCuD5/Ga52t5LMih0UL3ri2FVPbaGV4Jx8IMDPsl4ZlZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795015656;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0e8T89eYzWUPu9K7dGgxwTESfegPEC8iVLC/PK6QdBc=;
	b=pWhqEfIzEe6D1FwW29qaWSOTh7whEIB58+6IvZ2DQHWxVhcAWtQy+4HZz+WW3z1c95S/
	 DxzXGpS2mT7UUoXpu3ekFIPOGncUI9HvWLjyAc/6m4N5H+pamfp7tfVUfoIYWiXTvBcxE
	 N5PnZv9IxHXEQELpVaUZm/6W/5cfURvMM2GO8zSRtN84CJ/hPOumGGDtkCWYo9tHcQy63
	 9KLJaLeMu3J8dstW9V37tSOLWwlivXgsvOhWpYJYpjsr1UQKCtq95tdHr2160KhHsVMtR
	 tK9gLZIc7KyEY806L65Wlxf61zscjvVMd/x4FvcTd1IkHBDKXmNV4X1CrG99Uc/R0AA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795015656;
	bh=0e8T89eYzWUPu9K7dGgxwTESfegPEC8iVLC/PK6QdBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Eb0Dcy6Dt3byxElWXJbDJYR7u+Opgcf75KzSwVqvmBH+RhP4PFujouN2VWXzo1Y85
	 6bSDsxruIJYswC2ht5lxaHZFqpQTHQ2/8eltjeYW0vHeHgFTJmj4moQhqpMlEcJ3nA
	 YJMU80pXvFZUahlkNginLYkFzNqzYcvaNrhymczcRTHG/iV5v8LqiqVs2MgacktH6o
	 JVSLlfEgRtl6d9vlaDtYjzdJhcpjfdj6oNYayx8Rc142YSCaE7GwlY1GkFBq101hJ3
	 B11IWYt3GvlPQ/+hbsQ+hK9lkKn+yBAxoHe06GK8AssikPpLNJ1UR38CZ/hiBBcciY
	 KKteci8itBPrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88EDA81230;
	Wed, 18 Nov 2026 15:27:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69B95977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C19640481
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11LKztO-rNcI for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:27:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 78167402A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YhLffx/E
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78167402A8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:27:32 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-717080a2d50so966242eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795015651; x=1795620451;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0e8T89eYzWUPu9K7dGgxwTESfegPEC8iVLC/PK6QdBc=;
 b=YhLffx/EILQ6b0PqL3o3Ur8SLzXvfCSDTIre/jfPy6u7hZVN1+UfiYVwH9B4oi4+bH
 zRUBps26e/BhQhyD1E0rgQ2vaGI4C3YFTeZr9wToAuyLcXemGSN/mzJy0IWl98Fgj0+L
 B6nvf3RRfp8IBQm6QD5As/24Vaaa2LSMEVp9uRZE370c7WzM8NBioEGuFwc0UpT+VHHu
 fMb/S0bNiI7b1/cQMiEENxnOh5OLkPphJbjQNSPJgOK1Dq8QcfYl3mpbA7LdTykFVdGu
 Yk38cL1LJ+DAL+yjZW3Tn989sBWhYHhW3liBq/u2suOZ6ps/5VF9+/DC+/LJLiXKKEtm
 qv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015651; x=1795620451;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0e8T89eYzWUPu9K7dGgxwTESfegPEC8iVLC/PK6QdBc=;
 b=airPGv5RqSk6uwrKz7N3bOxZjsJ3weRD2va1RiuvKO6WA9+/gpHMFrnJQT0ZFU6aWt
 loUmG+J6cJ8sDr7ZvlAym3jZMNORuDp3SJge3NHlLWWA5Rw9h/wxCmrup+zSf0U7PfbW
 7w3e0sDwGbBL3TH8e8GdxSvBLFrXi/qpquWlLnEDQxw12FXdYQU1wC4lxQZoMVD9Fvd5
 +U3jjqNzSLxaL1kEkVWZSrtDeVw/VdYzdvkvZ0PCtDwcMltM6v+D561oOWw6MsIUCAtv
 YtXzUyqOqjBaA5+7pw3ygf/IkE7A+99aGKS3G+nxlEHDj6yWiG2I4Rf5PHI/MG95v4I2
 eEjg==
X-Forwarded-Encrypted: i=1;
 AL+hErHBmjHfSzk4BvI2z4x7u0gf39fFYIHstdLX2kYVTlBb7d4MId9fpEDNN7VFI9NPvS17gV4jDQE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/c7quaWzvYxlMZeSdOmyW6anh7Zd/1q2odTLmO6ISfPsT6haOQ
 7ofpNUalCZHYkYKPsTu87sLgxJ+KqXPGAkucsHZQAZlx4U8fhEnmF3+ggqCgbiPY+E8=
X-Gm-Gg: AYBFou2nRWUAorQ6vkkOuIBKlHfizyNr5XbPLccUy9GvXNU7oNPAQRzOYANS62c/w1+
 XSUMBlMWcTl/cT80ZXVSKd0qCCBeVcOTioR6k3bg7+GcT6hA7lYUDa77ev5LWLusDfV8qGNwomg
 /IOe4pG+P6TWiCHp/TOwe+GwB/6GLVTRKc9/0kl/BYZ2s+p49ouS8lVFvz7/aWdwPDJExjHFSZ2
 kbsl/IKhiqOvk5qbNvjVRDPkgEokuHk/wsVgH9oYTf4/j3mLPkBA23gmDBOIXrnD/PQlaRxhLT9
 EhhcPkdWqpkv+KPlsGgn6Fvbd5grgaz8qXS2w490jWS132N8cFhxvLfy38tIqepY1puo0Hpybc/
 qnmk9u72CBVktRxupRFxOqSuI3MzzwT2jjzEZtva/75M/aK2mlnhPtYXAB6VkvP0nmS4c2yjeaS
 oXKS0NemPgEFI11TZPTzN3dimYdtt8jf/v1CQQix9tUgMa0rzccWhlMKvnRnB7XzYsgI5uSlTwl
 G9cZiT6Ccj2U8YDEoomMwO6fC0CaM2VFA56WCoys1V2wnoQKfdGXbnoi5lSccTk28h4keOrzmMZ
 c1yfxWhaFIU7D7bA6+yVp98/5QebVH9SlcTGvB5l/PQO5Y0dA46ldSmQIt9UIjk585AT5Ca9Lyt
 tpU0G4GSuxJRnKRwX4CNIIA==
X-Received: by 2002:a05:6820:440e:b0:6c0:dbd:309b with SMTP id
 006d021491bc7-71b1857dca5mr1933076eaf.59.1795015651443; 
 Wed, 18 Nov 2026 07:27:31 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:9834:2835:378c:43f?
 ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b73a003714sm2462040fac.0.2026.11.18.07.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 07:27:29 -0800 (PST)
Message-ID: <c7e80a77-0ff5-4e40-829a-994580e9a16a@baylibre.com>
Date: Wed, 18 Nov 2026 09:27:29 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastboot: block: fix wrong device pointer check
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>,
 u-boot@lists.u-boot-project.org
References: <20261117-fastboot-block-check-dev-v1-1-31f05c746bfc@baylibre.com>
 <179500991180.1357981.14786038924649135328.b4-review@b4>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <179500991180.1357981.14786038924649135328.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 7:51 AM, Guillaume La Roque wrote:
> On Tue, 17 Nov 2026 18:08:01 -0600, David Lechner <dlechner@baylibre.com> wrote:
> 
> Hi David,
> 
> this patch is already part of an other serie :
> https://lore.kernel.org/u-boot/20261115-fb_gpt-v3-1-7ddd7ef832f6@oss.qualcomm.com/

Thanks. I didn't see that one before.

> 
> sent before you so probably be better to use QCOM patch and put you
> review on it.
> 
> what do you think ?

Of course. :-)

> 
> Guillaume
> 

