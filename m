Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5E7C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34C6D813F9;
	Thu, 13 Aug 2026 20:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MMKx0UBgLrik; Thu, 13 Aug 2026 20:17:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84231813E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652237;
	bh=ZUIXjwLc1nsW7y5e+bDe6HpD0LI5250soeBDpbxXJW0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XLsb6XEuvR6ZOw8Aps3E5bgC+6LwRMwyjxcm0RJyK5bzsQPPZ1ui64OLD8wGJ3o/F
	 EUTF8343Irr4Mu8mwHuut2NvPdWf/9pmzqEeHv9dTI2C7q/QeMamYr3wj1j0Eamlr8
	 QNPrEeKTTtj7hSSk3HURXDJ2LzWZGN4lW7l3wSW+J3B//JCzDaIZU9iwy7UuR/ro0r
	 W2ynudRYFOIs5iFpOfQxXfjEkkmExGJQVWD3HuLc74MJ6G3ZU28aATZ1RWxnRkfYeR
	 r09ePh63g4EMB3egjLhGi+34/9/sk74sGY0wdb3CAyveMyotd2TvZNoJfwwAtFenk8
	 4J6BfYfip2Scg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84231813E9;
	Thu, 13 Aug 2026 20:17:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E917139B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24F94400A1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7OURAcJ645LU for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 20:17:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6D91D400AB
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D91D400AB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=SPBRW49G
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D91D400AB
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:17:15 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7ec1e9d3359so286532a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786652234; x=1787257034;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZUIXjwLc1nsW7y5e+bDe6HpD0LI5250soeBDpbxXJW0=;
 b=SPBRW49GNQlvWqgYe+Db9TPy6mXXdAxwYaEvjBppSs+9pzKEmWpW8TQtILLz/ogYKR
 25rkupK0fUiJvyr2VOAbtkz2rY1nUdZLNmAVNoTZnr8hJra6R49kUHZOb8SE3tydJZNB
 vy/rsqlQtDY1vB3tvHZG39EgI7yXTbVG6mEI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786652234; x=1787257034;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZUIXjwLc1nsW7y5e+bDe6HpD0LI5250soeBDpbxXJW0=;
 b=aBdDA6QLZ6ceik1dMqDe6Uy0z+Ki3k1L8NM3y7Z1TYSkmCEl4/BC4RN+BtBmXlEDgj
 5c1WscI6e+r4VN/ubKfCPcR0o8u44/naCXnski9QxvflR5zFs/j2hSEWk+zrsuSj437W
 c9ac0+pGWy5CEzfu+AWN12NbNI65RXod4tGfcZ9hylm/xI/Xh5YcuQfHcMPZbB897lP+
 /6KC/7H3iUrkHNm+vSTep90udxEl9wNZFPKm4GHdzJ8JSnlykgx030cTwsyVOMVjnfXH
 Lz2UuinViAAvIAEZl3oZypUrGAKyUwK/LQiL0SLItLuKOD39ieyzD3sl/O7rWHjbi1Su
 QQ+A==
X-Gm-Message-State: AOJu0YxUOQBlm3PhOyZzF/udGd3tXvVT9r1NVfYaWoZHThQg0ikZaAOe
 NF62ASRsx6Ea2X/rCP6Vdg36gbZsaZ7ORer+rBOlJfmCZqRTJJ2vax/rh9toJtX3qjz2i/kwgVc
 XROd+ZIU=
X-Gm-Gg: AR+sD1082zEaQCSqL/c4VAWuH22PD9m2doMCL/Mgpy4jQI+XzCwi1E92edPTfTMOREh
 8IxOExy4QafSylJ38TrxcwZQeBr+rXGmObac0yErzqpBw3zPdUUcxBc23XDP4eIZP2cL/7Ed93y
 +rTvlXbk3CoNT/1vYXarg2JlY1z1tAAixJ12fpq+LF+0zZrLOMQA/e/VRqd90IH6YQFTIZsAldH
 KErBIfqvtQbn/lryauQA5Yeh5ngyOa4NyGK7oJ1rZQoMuy+VJ62kRAOHW5O3FY3FL8dfu7PRlSp
 MncY+YUc8E6MO+WVrkIWXfwZeK8kUv/FHtJGN8KkyUcoFdyrYCu9FzauLoxm4mR9THsTr+nzkkd
 irTSKI0IE64Zb/55BLzFQSYZ9ODX3MO/f/sTKSFJoZKg9o3Ugec93zAM7BCSHcJSFDcTocy0Ygc
 FTBWnsRBRNNX0+h+cL5+wngFK3LYDZ6pEU0TWkkqAWo1nJP0cqB7r1qzNWdfpmzq9QzGjLeRihc
 IdIBncsebZfNDJTauLlMjfwl13SPan4XyQMbPOydkZRfx/2o8IUGk+KD7Cvvt9Hhl31zDyIzwwM
 LPW83zzwfXmQ30lSbVXg
X-Received: by 2002:a05:6830:4704:b0:7de:5bad:ace1 with SMTP id
 46e09a7af769-7f3de5f54ffmr332921a34.12.1786652234410; 
 Thu, 13 Aug 2026 13:17:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3c974c65esm3016397a34.0.2026.08.13.13.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 13:17:13 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:17:11 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org,
 u-boot-custodians@lists.u-boot-project.org
Subject: [ANN] Further mailman updates
Message-ID: <20260813201711.GH3297518@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q5wQhZFfBxWblQ7h"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--q5wQhZFfBxWblQ7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As some people have noticed, with the move to lists.u-boot-project.org
(and OSU OSL hosting), there's been some behavior changes for how people
who use an email provider with a DMARC policy set to reject (for when
certain actions happen). This in turn lead to some rewrites, and then
things like patchwork (now updated I think) or lore (is append-only) not
seeing posts as expected (but seeing them as the email policy wanted
them to be seen). The good news here is that we can get the lists
changed to the same behavior we used to have (which also means that
gmail might see us as spam more often, but... who knows). For the two
low traffic list (board-maintainers, custodians) this change has been
done now. For the main list itself, this should happen sometime Monday
morning pacific, and monitored for problems.

--=20
Tom

--q5wQhZFfBxWblQ7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCan4mQwAKCRAr4qD1Cr/k
CpxrAQDW2+7He320e/EdOca78609houeMwKRiUcQ2H6ryEnkNAD/W76bke/qHHnY
5rUBVdBfa9CEpyDmkT7UrP+cFLz4aAY=
=DDWV
-----END PGP SIGNATURE-----

--q5wQhZFfBxWblQ7h--
