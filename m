Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95381606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uP8OvSuj;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=f2Kd9c0/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7178F811F5;
	Thu, 22 Oct 2026 14:19:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W8oGrIhAuX_w; Thu, 22 Oct 2026 14:19:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3111811F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792678773;
	b=AiUfW4Pg/vsy82RSCGorpIjT8qjXnI6jp6nWb4HUfx9cUz9v/p4VAuyajCLD5nFPOCei
	 qAjIVLoGWfDGl3rM6gZn0P9JFHX+5i4IPRSgoOScXCtmX1CV/WAYKotOJs8AOM3Clb1cM
	 KQFyye8KHChA+7vYlL0MG8CpCsd53+h7ia8lOjX8d2LItk2AxIccniF2G+aRiqKmQNwTb
	 uoVh0qkVkcxJd/TiuIvmQ8Qm9k11CHr/8UktsTbJDORwr3DxEN+JBP5P42Y8de2nUZMyo
	 AD2L6r8oPRdHlzQEZPej3fpnrFOfZSUEctogrwEKEFs9Qssc6fX4ZpyZ9FocZLrKUdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792678773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vgUI5pxc8jaRCNjEj31cl9MuCXnfE18XN/OLzZCYw40=;
	b=R/Y/6e5El+AOpyvKBG/2WowsDE3YUm8FdxKfgNPtny2hbRTcHbafhZfe+5f9d5orlTom
	 Xag7BLz8nIP3OD9KTn3n6himJgfWfNmVcGH8dAHbivo9H/JixlbEcQeOzst58L+mPVCap
	 loyn1g/p31sYjEzYGxhsvXRzkkoLAZtu13QJRQ8bXP1V5lkn1zKeIvgGwfIiERMnp3U/H
	 iAGeKQ1AUMQ1UIivDeG4EuL1TyZrKY1tCXE3SaPJ+jowjJnKIPbMfSnDyEQgSY7gKLFh7
	 N8qqwMnr+E+JWAL3UFeRcO/US4GEG7wlo7zcbDk50htXcnKJPSyebbVfR7C03sySZLA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792678773;
	bh=vgUI5pxc8jaRCNjEj31cl9MuCXnfE18XN/OLzZCYw40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uP8OvSujk7SazpyWTcHofBbJP9aI4T1e01UnaYtkhkJdQyUyrGmcOokTaJvzmekGf
	 g6TSc1rBMhvvOQQGZIcoh2s8zftfVbeeDtBCcLe6qgN9+yCab4KAHCl85ZugK5p4EE
	 6M/C++5DgYFVzR7XP0txVKBra492tbMkWv6cM7AfXOzxgU8HiPiofPmfQMluUqRwJL
	 twVQnITUuW32buI1VbJRtywRha3IkCIifcm5B/jCVXFSsNqaTDhNdu0xegGMQSw+J7
	 4OW+TZM34+DORwJdkYBBfRM0GTcDVC944KDyw81QPw81FSNNr9wnGXnFwqnTPDGl9I
	 QG93M2bab2Onw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3111811F7;
	Thu, 22 Oct 2026 14:19:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59D9095C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8ABD6070C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0e7c07DtrqFO for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:19:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E371F60686
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792678764;
 b=NtK+HqD6eLFrjECuB6OWKiT2JzkdDbbZF3KjR7crvnYB85MAqEcsB418kQM2idzxo18z
 GEfE2VayJmpu1nsskhUihoZASksE/n/cbYj+Fj39+3IGk1vG319HYT9yrrj4Y0Ceta49b
 sp6M8JfmEKSaJC3n6tnfr6n5kr+Ll+nRyQ9R/7gtG0KMegsCdOOr9lpWK03fiAoCPzevU
 dOTgsSGoBB9qY2OqW+c8jxO3BkmDeFYvIFgkZ3e33a1H9SJrg0MN0OUMA11lU1gDSs0xO
 XJM7erewnzfIAExA+7mpx5g88mQwARyEdZ97RZOqPHMlnETgOPuGPfn8dybMrtBYlqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792678764;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=vgUI5pxc8jaRCNjEj31cl9MuCXnfE18XN/OLzZCYw40=;
 b=Vmn3lkXKIIW0x5CT+3cvlXLRd7H0aavpPTdNDy7V3sMhlftKI/Bk4PFlInUSqTe/uSzL
 vGeCk4bsgmmCSFLMN34tS6+eEQXu8PUDcV4txALF/MuKePSnMcFFJo4PdppSom1jKb/dK
 clnxhPdZb8vj6NM1uBCsF5KXjUzdzzaYsoRYxOdPYTHzLT+sGQxt2NHaB1+Q/Gx80luMI
 sYI6uM4J2nnEYQPB0dTVRtEa7LR8nDl3HbEbNkiYW65go+6frPfysVY2EK07aj8GS4MF4
 zYK0SjAFcp9LXQgsHkUat26xwFoRyUTYsJ0VqUxPUkwrRSM9QK1kwx2EMmnnLGN6bLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="f2Kd9c0/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=f2Kd9c0/
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E371F60686
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:22 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-84e513877a3so649094a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792678761; x=1793283561;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vgUI5pxc8jaRCNjEj31cl9MuCXnfE18XN/OLzZCYw40=;
 b=f2Kd9c0/m/9lBbJQxg+mjo5gG0k2CpqnEvDWIW2jkZq3IDFPidJDp4EcUvEpfwJCce
 mUapIfniR2NuCh/uHH1hsM9wYaKwYbhwaWwY4KeobDgnbUurVdxkWv3iDK54Tp4I899i
 vw4MLVjg6cz9rT/9k40J4ZC63zsNiNZWMJLDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792678761; x=1793283561;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vgUI5pxc8jaRCNjEj31cl9MuCXnfE18XN/OLzZCYw40=;
 b=qxC7NrQ68atKQ2F68wb6NbWRGKhOGDLx26i+5rD49sMW8xQC25jeog+3UsX6iMrFGe
 CmMiGwH8DiVpIiX/ImxSwEeq2zhKymdsSJfKa58eX2AmD+oUiz6rV7Qrs7dx8OGLBi0G
 ul46U0OWL9VLA+HtS3Ps1J8IHO3kM/AiT+I6+aG2pVbbpb9l2CIumtqzLLe2khz9WIKm
 PpRBqqvGlIPd07mTuV4ULs1zlj1NZ6+70Dkomw3jMPmH9FbhmVicHqJc15qpS9JBEZeA
 JZrv//N8COfHmuhbZDbPwNoxpIinnA9n9ez0XMyEnca6XkQZl5w3DytpX+wxJSnzO5ag
 a95A==
X-Gm-Message-State: AFq9FYL7Z67nYbbNu999hsgTaXAJLMa9kOQ9pJraJJPhRsxwHPfPwSCN
 UFG88iD7dP7TjEUf8tRNaOT+RvPVT/lwrFTvsK275BpY/nUUEALC5r/xaywtUCJEhUE=
X-Gm-Gg: AYBFou2jjfLTAnUNYERBW+nXLFWGK/WCypxUFVb4acsAjqw+Gtzqx94OCx1gXDmxW8c
 7ulTQVLqlycn4K635vterTmvfVdN0tAtOQPg0fb8cvaABULgZhR0bA+gdTLbiwWXcavnqvFpNu5
 6LwspAB0RDJN7l28icVhSiQdRMKPvd4nzQhqLN8pBGSJcx0aM3PTDQFo281Ezi4YT+UyG7MALnH
 Qi7DuIL44zKFScMgrO5N6XuGJ4EpZPUUHVBFPF6xYN7qTjlgVr28FCAbDKvmWoXgIMusoGJNh2F
 ZHytqOSCGVYblJeLcsS0zxBuk9qrrrMFMvLQoOyF3SE3Ya1QXazL+KNJnmWBhphpRQH4EDReP94
 gNiPgY9ulXFZCHHtqXqx9k+eLEToNcz5Q47PXQBWdyNiuCWPsywjG8xRlQzITmidLjLS4FxeyDu
 IHAMoPn0nXTVq5CiMBO3RgGQ0alq7x4q1iWzZU8uHKjLS7goDIKTIEqhvQH8lvIALsfiLvrIjIE
 7aVNG5iSmCKXXJ7fjYrkCeRSj3Kkn2aOJ/RJPpt6RV9Eg5MHrihdqHeiAQ3cxTetl1/U7XRbr7s
 ySLQ0T8z7dH0wV17TWB4ws5lCM6TSsqqSHSI98ECz8WUt/TNlkAShj0uQ7n3F11M7sOTKA6F2C4
 =
X-Received: by 2002:a05:6830:490c:b0:821:dd7e:330a with SMTP id
 46e09a7af769-84e3052bb92mr1243746a34.8.1792678761634; 
 Thu, 22 Oct 2026 07:19:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2a76sm5506744a34.18.2026.10.22.07.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:19:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20260919202630.3366037-1-valentin.haudiquet@canonical.com>
References: <20260919202630.3366037-1-valentin.haudiquet@canonical.com>
Subject: Re: [PATCH] video: console: report damage when showing the cursor
Message-Id: <179267876086.3588521.1892081800812931488.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 08:19:20 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 19 Sep 2026 22:26:30 +0200, Valentin Haudiquet wrote:

> With CONFIG_VIDEO_DAMAGE, video_sync() only flushes the dirty rectangle
> reported for a frame.  Every vidconsole write path reports damage except
> the console cursor: console_set_cursor_visible() writes the cursor
> straight into the frame buffer without a video_damage() call, so the
> cursor was never flushed and stayed invisible until other output dirtied
> the same lines.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] video: console: report damage when showing the cursor
      commit: beaa326ce901da3e3cc91d6b6cd9e12b32fad6c2
-- 
Tom


