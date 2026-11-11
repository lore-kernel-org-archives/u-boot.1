Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2327606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nX98ijdW;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Wub3nPtm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C141408BC;
	Wed, 11 Nov 2026 09:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fkc5zn6ku2wB; Wed, 11 Nov 2026 09:19:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E6C23408D2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794388752;
	b=hAt3v+IV0TSK+QeqiKIE+/LzajpFhF3nXAC7SY6H4IKj0kh/+LIXG08c3s//aCKKCF6H
	 JRGHuGvXyc5zarPDyqq5U09zJRZc0CBVUjgLgo/mh++0ZZ3Bhlp7OQahL+jz6fZ4+jhVP
	 4jI7DFv0MTj4IggDkkEzEXc+E0FZb2UgiGldXzOVxrLU57jZShXanmv2aqtRMd7MFV4Or
	 PyJiRSkZh/B50dpFhLCA5Nu0JvDJE5oSi/7oDye0NIXnMWU8A8Xidz/IMklH2XeukzGGb
	 lhZhue+w0xC/GqprXafC1VJKF/NPyASlGIW5Wpg5a27wsQouP/cklU77KVGAoIdrJ7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794388752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nNLC+azEnYhStHo7X/Z8GqkLxf0fp+JnhkprAz/StiQ=;
	b=PY5TqPcnf1OLAi/piF8fpDhe9e9P/P/IVd7l4V28GnAmZqh5TzfTCWbniBRhSy+fJZ0F
	 eKAsaYGAijlNzbi5Bu0TnUFaVg0F6192s36oLNYwSy3K2jyIIT8c/lZWDTzBnmK+uQlQm
	 gM5KR216Yws84p+yB854IACdSlqkNiWgvgg/nqRFXCU6GnkuxFard+MULFehbhcKhxTV0
	 mEWpgmmKaClAAyhEJg86Pr8D4vFSrode/9B8KD721AIDGBgEmPOZjXCcZzIS1jCHFh67g
	 VZHDK8ou/n4qPa8eLmAEPsdcb5pnu0KfXJSBV8S+HamwL8zUm+OSQvUYsUwY234QFWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794388752;
	bh=nNLC+azEnYhStHo7X/Z8GqkLxf0fp+JnhkprAz/StiQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nX98ijdWlAMCsBl8U6twyEa1DPid+p4ODrAPXqK0iGxSh0uXy15srYHfAEKpIz+yo
	 4XWMTCUQWIhPtVArwwnLyaL6NGw4/bf5PBS/I3Iz7J8qOGBghmcCFQsNldOa3dtsLI
	 AOE5zYLhi3e0utc24yGUvOxlngEhP16FonrkjwBpKikP1vmuiosbe8sWcy/fpfxl/f
	 WXgie5y5x9OvITparowJAmDupSfpJ0DUZdRaLfLo41s7nG0p91dN5Q6U1R2N9YY+/V
	 iss7Kz2prSmwGPyZIjFdSpfkDY+l03ZXoz89fChzG321nkalM9BZ/UA6W5w6FxtxFb
	 1CdglrcQQkuvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6C23408D2;
	Wed, 11 Nov 2026 09:19:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D83117CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E716140318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yjNznqmr0xGf for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 162A740070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Wub3nPtm
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 162A740070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:19:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 956B710DEAA; Wed, 11 Nov 2026 10:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794388743;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=nNLC+azEnYhStHo7X/Z8GqkLxf0fp+JnhkprAz/StiQ=;
 b=Wub3nPtmNy0WMPoXMMsMJt651XFGh/ZT+AG5W4fhVvw8zanAAOxbK+eaDZ8G7tzR/LDEtY
 yJgtPYEpvwlR7SKfmh4u2eErd8PKYaimhILkC3OfRvrOXW7Soqe1klJUzrQcD/sXcu3zGu
 9LdLtEBjn01gHNbuNIM3ZV8G3nvKuq7bbeafdWflFqYyGfeXAi6ntrkZqW5+bXCwQZtREl
 9tQnbtOG8W6VYxUmmU0YSNto2+6Arz44avUsMRxXdk+oq6cBgOHfUcHHhuetiveOkRVH2R
 9Xhuv/HIAYS8rMz0uJmRHHdeLdtK0NnyZ0jAEPxsTa86XEV/V0MeRoTYVzVaJA==
Message-ID: <1112d8a8-f4ee-5283-51fe-c82f8e2ffda8@nabladev.com>
Date: Wed, 11 Nov 2026 10:19:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/6] mtd: ubispl: check data_size before loading a LEB
Content-Language: en-US
To: Ana Bobillo <anabobillo3@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
 <0390b590-ff95-4f34-a7f0-833ab417292b@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <0390b590-ff95-4f34-a7f0-833ab417292b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Ana,

On 03.11.26 08:12, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
> 
> ubi_load_block() reads data_size bytes of a PEB to the load address and
> computes the data CRC over them, with data_size taken from the block's
> VID header. The SPL loader checks the header's magic, CRC and used_ebs
> but not data_size, so a header claiming more data than a LEB holds makes
> the loader read past the end of the PEB and write beyond the part of the
> load buffer that LEB is meant to fill.
> 
> Treat a block whose data_size exceeds the LEB size as corrupt, as is
> done when the data CRC does not match: the loader then looks for another
> copy of the LEB and, if none is found and fastmap was used, retries with
> a full scan. Each LEB now adds at most one LEB to the loaded image.
> 
> Fixes: 6f4e7d3c75a8 ("spl: Lightweight UBI and UBI fastmap support")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   drivers/mtd/ubispl/ubispl.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
