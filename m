Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E412606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PrrwBbKe;
	dkim=pass (2048-bit key, unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=eG49d00Q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05531607CB;
	Tue, 20 Oct 2026 12:56:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iaKsTaWz9TYm; Tue, 20 Oct 2026 12:56:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EB9C607A6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792500961;
	b=bJa7CMHBsdxOBKS2ZBCxZ3SlEjrhs4WM/+iBXEfPQ66qUNU3igWsKvHkbwC7h3xlmu03
	 nasSxic/x4Wp/HKrm8aLI5zfpGWJ0dsK1x/AnGSnolEqBlnwdxuKPfERE+eY892MUqp06
	 lle40ukP17pdtdK8NShgpaGaoAA+4TlvEhqcgNhDn1P9kUhjTlLxDiACsPHX9XSoL/oSj
	 rTsOuPs5vRaOBn4b0YGDDL6MdWNgbIvmJpIjTmrDD3DR/+xZTm21hTQXahApL+gGZqriH
	 LSNQ+7v427f4Q5qliPgUNCaDCZwh1iJBSU2jGmMHoq6lWMMAm3kcuVVY8aCHzAbg/8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792500961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ugZZZL/ikbr9w0Y8tmMidOPeCtS9uRpAlB6hyVc41PE=;
	b=E2ODmsqF4cnVoBgLfJZ15HtGa7cF9GdXyG1nzFkj7pwpb7eL3q/u50MRWFE8l2RAm9zQ
	 hW61swJ2TDHPwvgt79KX6WwGE6Z5N9+Td4zREyIfvz4tjimPsJ0Kvy4Ehk6w8JPF8o6EN
	 WXwnJzGHdIBO3DLxGp5PYeZLt7Cl89av32b/JmkqO1K9KFxLPKJhKl6WkXlHp0uXS2+2l
	 Kz9cWej848mgQ8pM5xPByVW5EvwL2sTVLUXQIDjofQTRYR6swtYLD8qo198caBye2u5mO
	 vXICMIgvDEjY6VQbfoe1evUOrOV85icLUF9gLxmD9YXYBs2GpDNeZi2X5eBAHYr+oeA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=sigma-star.at;
	dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=eG49d00Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792500961;
	bh=ugZZZL/ikbr9w0Y8tmMidOPeCtS9uRpAlB6hyVc41PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PrrwBbKe80wosOHyityIIQG5BIfFdbAeA38s4ai1YpISOWt3Ihne8MPGU8BGtuzXn
	 CcoWSaquFnqG4gtoVHDLQ1AsavXZv9z8HYa72pYGOZg3EK9VojfMDbdz+dCPBSD9Zr
	 vkeRizqlacJ9bC46pdHvJF2gxHnpzN/VAW6OzOb2KMtMqcl67PYZ89LBwEUpC6cqVV
	 O61cTPiW6rTrYkhRwOpVjoxISYoP0aAUG545/j7iNjo4NKeKtM4QNHhvW9u6EEzFgB
	 dlWneZeMRUZpMWFcT9AEv3oqsdO0eh7TLt4/gbq7Ui2W8sC6dVoJ95Xbkz20dgFjEH
	 w5DXwV2vCJR7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EB9C607A6;
	Tue, 20 Oct 2026 12:56:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E13E769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E616607AA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rp89W8IgsfJ5 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 12:55:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 548DA607A6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792500956;
 b=Uk+0CNM7iUE7qLl1xjK9R/ZFgzMvWmqVofJNk0xsEEpz5cJOtbrJKCwY1ECun+y7U0SG
 IPYYL73h3AsF3VFnybkPdHzC5AT9336sw/1Zk+cxItHasP+CV526pE+0eJOfNpjR8htiF
 ZRlyK+cpOTdWv9e8O/OmTBkLkEBC89k4DPll+qjdjFBHNAfaSV0VJLlMYZaMBrQJ2GQpS
 eqlk0FkWYxUpxJVRdTQz/I/ez6B2qREspkp8juFZvP/gBX7Rk2dWAP5FZNi0zAG3/KgEN
 KVC+TlPmiXrnWZj2xxZkCdMNCigJmj59rMEuzT9YwByiOFK8jv8wLPVEGyLN4OUmkuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792500956;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=ugZZZL/ikbr9w0Y8tmMidOPeCtS9uRpAlB6hyVc41PE=;
 b=YlzmAJtlPGRxPji2r9BQUzQ2oFM/2/9TKP2NSLKsQTNFb15/ZTfMXc53/y7Sdrwjd2A5
 Pi7jL485BbXbV2vN9O5hZOV2swf+uLr31APDdl/7612gIwIAZLdQnK7gq/v+8l60EXREc
 v0mM0EsYmioRiSr4VvnZXiFNxgToFH8AW2fiDwcHGghGsE3obaaiIyEPzpkSb/TBB1HCy
 e+nh8LiWojS5DAT11k+iMcwAL/IvsxcZPKUhmzScOgYeCqeyGjP/YYEGNZo5ht8ZII4Sy
 /tKZY0G8JUvCkKexaj4FZxqLke2g9vJ6g3oYmL1paSq+M1SZkSIj1ek5zoYMTicPXqw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=eG49d00Q; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=richard@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=eG49d00Q
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 548DA607A6
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:55:55 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so39597745e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1792500953; x=1793105753;
 darn=lists.u-boot-project.org; 
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ugZZZL/ikbr9w0Y8tmMidOPeCtS9uRpAlB6hyVc41PE=;
 b=eG49d00QdabKmbLImM+TvIkCSEmCISKYftm5ltCfmwxeK3TFHUahg2MRJlc40S8o6x
 w55aJWcMLDrIFhwETiOL8/ZLXb5cMnm0GNlpRblrroLNqOBPS5RIhQHmvXI88sGl70Tt
 DLezOMTEyVvv1HqyaEepWGbBzSLHQ4pzAIfaP7i+aeIhlLBwm9fRlgkBkYmgP6UKCneC
 BwD4QHIT14vEl1Ufba9WIqVIFrAuHXEYImP6mWvTayFy2C4/DeSqzr9JIgYHjtmr9ccD
 bq+b2QsJOaJ/8J5x7bcsrdZzEwI4cX5nCokJ+GnI11FOK0Snlu/YqaHoaCE5qpC/8au8
 fhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792500953; x=1793105753;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ugZZZL/ikbr9w0Y8tmMidOPeCtS9uRpAlB6hyVc41PE=;
 b=f8xTD3snxa16bvOICB8t1Ggqin2vos65R3NKbXPyyjuhpuGJoN2e4D/zK+GOWgMDzN
 RtMIBN/hlnMq+sSZiDRjc84wtgK+zuCPmuCN9GfDW+aNOcAFgXOYQcuE2h+0wi9HuBte
 IpRlbnDRInrewzbF+CVeRDSu4LuhgAvhCuAjbEY6kBB0DtysfihKsFggU/0Q70JicZnt
 cRlB9+eaD8zOWd1L4ySB1uqGV+Gp0cloENI5PDiiKNoYXrAk4Qfl2AE4I9EiPxzDFprh
 kl/o/A4sCY9RGHHRHYE44leyOrL5jhJLiobl/q0uLNe0UbAE92bvagUYFIwiGdzPaRj0
 khGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuFBdS3jalLwXl6Ptsc7/Q3Y6Bm6mbthtNWzhgV3p7D+dr3zfjOBP317jzFqZC7X9NtTzdrCQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKofz6uajqIr/uonIEM85Se2UQpqXbFtPeRQR5NicvtpmGT7Ipr
 IZVb8Kr+TJbop+nvXp01h+tfKm6U4Zf3cCOt9a0F5GFC7dM1rI9QaDa2JmhybUnZf+uDBcIIsCY
 S7RS9/cg4uw==
X-Gm-Gg: AYBFou1KC5vWyD1hqIWQlrzAIgHNvXU/1ghEReDrXzxPRUTmQLxUgNt/wn3eAsNDtcG
 Xj5qSdkANzmK/1DlyIzQGtc2Kx+Y4n1PmHBf/8LIyZ7QpVj51rEDdYwuT7MouyTDcQnCJUJF8UE
 g+vQSWnpqcqNqJtprgPssKyv/PLhFr+orBhcxc4jq5R++uOdpKCMAsFMmQ+0jO2RQJyvFKLoWlO
 iOKhgQYL3+s6zP+r8wzeiAW/6+lIUikjV8Ue4Re7axjJ41xep6oFwucPsAbqswiVeLMGzvT/iKY
 WrYioZJBxK/niBSYX+6FOoENsGrWO2vgEpU63RlHv7fTbAOttcpp2RPwT6cmATjQmWvMRjPY+dU
 F7Mj7hQPOkjW33yxDbKJ6ibYTKLLrwhWRjZHgH7AhKn7YoThaYw1oP6Brjpv7HoQK54d2WFv13h
 HLcspZ0E7VcmcCdR82Wo7TAi0YW5SnxQsmPDEY9t0YFi5LjF0FcwbqDUW2Vh68oyIlE6D9xbgf0
 38pP+H1ZiVz4rx9
X-Received: by 2002:a05:600c:8486:b0:4a1:e7c2:9f48 with SMTP id
 5b1f17b1804b1-4a1e7c2a05bmr126829235e9.10.1792500950937; 
 Tue, 20 Oct 2026 05:55:50 -0700 (PDT)
Received: from somecomputer ([2001:4bb8:18d:5ed5:28d3:2efe:fa80:adfc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f6631abfsm54656195e9.1.2026.10.20.05.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:55:50 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Marek Vasut <marex@nabladev.com>
Cc: Fiona Klute <fiona.klute@gmx.de>, upstream+uboot@sigma-star.at
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
Date: Tue, 20 Oct 2026 14:55:47 +0200
Message-ID: <qUM3V7UPQe-RED8ASvU1mA@sigma-star.at>
In-Reply-To: <87500fbd-8f56-4d40-bc22-9aa68635f1c1@nabladev.com>
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
 <87500fbd-8f56-4d40-bc22-9aa68635f1c1@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Dienstag, 20. Oktober 2026 14:53 Marek Vasut wrote:
> > What if you have something like this in your bootcmd: "env import -t ${=
loadaddr} ${filesize}"
> > to import variables form a file like /boot/extraEnv.txt?
>=20
> How do you authenticate extraEnv.txt in this case ?
>=20
> If you do not authenticate the file, then it is game over.

Well, since I allow only very few variables who's content can't harm,
it's okay.
Of course you need to be very careful, but that's a different story.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


