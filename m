Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C261CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C50D605E4;
	Mon, 19 Oct 2026 09:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBxW8-I7o3_t; Mon, 19 Oct 2026 09:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8523D6069B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401265;
	b=dXnlXVniBe7KtDgY+so2eC2jj3A59aEyuBJx/aPDTsAz9QKzI7YNJVkAzoPPgC8GEESM
	 jSeznV2Ig5KPpD7aQF0njVJMhHPkKynI4HMa00CgArFlG4abTB3vy2nEFVxfIEHEkmAtg
	 VitTRiGcRoyPXLxKtaW++MLjEnjUbUF7S4fQvLjLalZHtcIDTpv9Q3EwaW/D2MuwjFaU2
	 KGQb31vyi1YFDU06FI3tF9Vihlpj+CTpqyFjnTRoVuFqHC/QW6S+dbtwHkhgqtkqa1mGm
	 ylVk6/kB+mk7HFAiaQ7fa/whHle7Pd9mK4zAxt27OXWZChvuuEgr3N63Y9SzfcS1RZg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t2PNbyOXM/ndjthXJH31LmTv/iGeaVm1gOF3D5tjgxA=;
	b=YW1jxgYkRzIMsihO0uWAJ3R9o+qQ/eLYPBPSG56yxSw9inKyIGR7HF0fM1Yne2xH/Udm
	 6H/2aL7DMhQtXm42E6r3FqF6cVzML4nxo5ynzsfInW9CCZXuF+zIOk1QoBdWDt9wr6L+S
	 QtemujPMFRAzQ4SKsE3NP7QLsHzeujdw5v1QJJWOLmyVDuTVSdQigD9pO9LlmRKuRpNl2
	 YZ67bjqtqAj0fzmuDrcj8Ni4J30g4PCbTGp5ucu+HrOsTu5kY6QgUmCxX25qQLHXds+bj
	 AGxoeMFjysdGhtrOYRvc9Z9e5rD7sByJUJ9wR5mTNRYirpcDkV0MbUzbvgXiBOtZsaw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=b1HRw+II;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401265;
	bh=t2PNbyOXM/ndjthXJH31LmTv/iGeaVm1gOF3D5tjgxA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bMQjQjQe3Kyv/ROkxUgnZZzb8cSWIdYW76c7LCt/v+DCjrDUmEwN/ZuQzz/5jFFgY
	 RbQ4B7I98Jhwsnqm9/fArNmuIwRVvHokJRMkjq5bu16YZOIXgd+taArsS3GiqaYgKm
	 KB+GZ+0JyysbsfsZ359y09my6HBvN7kr8v5jRioomGek4W5C3T3Y+m795Ozi5/AtHz
	 78oj44w0IUgLjxerTCzpToG3LkmfgeRiZvuQMtKoSl1q18zpi144owwedUTdfnezi9
	 VBQFWtGMKjnqDMqguUDwXeHFUm8pWl/3AhEj9Wv5xGovj6l7026L95rfDI05SwHRJM
	 IWPBa1GtMZQig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8523D6069B;
	Mon, 19 Oct 2026 09:14:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D0F6E1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B74606069B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5MZUtvPO2BNN for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33393605E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401264;
 b=LI/GXZ7m7bThcGsPpfhv1Ma1uCoMz/X7crQbVQ9HeTEAxQ+lW3aKAC+bw+HR3Bc2VpyB
 co/bA62kiqIQIIiu+QMHUSqAL4UHUESqP4rWpEUJAu4DTVGEhrUcngrkz0lOsmCtu2FaF
 MWCzH1pLHGDnzGKh4PvbUlMaOAlYocVYsYF7MR1d7d0knZs/nB90X6YfXG1MVKGvqmiEr
 9Y7rJifupTotoDuPEg8jODP5BHp/BDf9X0i/ttv62c9twI+Tm/PvzBNpIZUHiKTsUpoy7
 UhVEtXFfB+5XJL/Uv3OpdIuHLRU7phqY6Urbc4CT3t789f5B4R/VWbcrWaAk5+Wxo2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401264;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=t2PNbyOXM/ndjthXJH31LmTv/iGeaVm1gOF3D5tjgxA=;
 b=AsgTN6xNBM4LEtuVMr9AqShbyRFIhUtxBRmwIM/qzdBQ09/RrSHDDwC7mvZMKpbyeCOY
 LPHLCG6NXpGH/qXG4XTZ6D9rZVQd2K83fM6fCnfU92ACP+39rRmNxp/L8RGZgnFAiVFRZ
 6pHecyj5FhvLrj5Yg5KVmYDUyU9nfcX0nrF9ed0VqnGL75SqSuDckUbzRDpYnwRxDN+jQ
 WwH/cdXz7wp/ux2Mpuh//9A591TUC/U3TaF0skaXFUZWO0LgfUs7MMW3TszpftjwdHS7V
 Jp5YcoXNgavpDmnzwIPASLCGS2xv5xQOoNTVMyWr6t03ri1tWLxQgEb5dZATW5xwxDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=b1HRw+II; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=b1HRw+II
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33393605E4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:23 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so597026a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401263; cv=none;
 d=google.com; s=arc-20260327;
 b=gie+/0P+foxYZa2dDtCvLt/dl9hpBckCFIfggBKixCaSzQXOnZFGsn4k/5wEIn9Wsb
 hwbQyaup5rQUPN6QhZJxNbVx5wYyqLkWH4ZRM9X+lRQZwoVzcraytZDsv6lU+GFzqjtw
 TdzwoppYDeTQh9TSI4y8DA2xyGdz4PggfDto3DhwnuPoRAOuXD7uSHyz6sKHSb05U3t7
 Ck6RNrdJP5amhN6XTVRw7KZ/GWVDCKBTAIn+h4KFr6Nb9UGURcUY6xMhRHqPe8WmDyVf
 SiQDudeR5bADR5RXB5iDySmmIRUJyu9nJpUCkyK4/uLuQQMFA0bJ4D8EP9EtuGFg1IHh
 vhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=t2PNbyOXM/ndjthXJH31LmTv/iGeaVm1gOF3D5tjgxA=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=lOF65QgxpBU7yyy66YlH/fsqbXS669t8Bqz/3UWSaewhjoeOG/giPh7OZmsBkbx6uV
 N5e+FiH2KrUVqqg1493A8KCt9JLiZcV7Xhsu29uFa25jGVcH3pRynPHtH0/gTgMQl2B+
 KOsfuUVpZj319oLKKiNxiG6CxFAbJfA9rD0N1buHyl5qmuMRsqQvLgxFO7W7KNp8tsKD
 cAjfd7V/Nwf/VOEHyF/LXkf9V8bgs5wCnFsORwn2vhZ5ZXpMvxs5ZT2aQi0oCvm28IIj
 zL7uhc9VmSchcmsNHWlbw4d+/7ttan9x08FJleMMh4VONPtGbpNJGv7zUoxwkcofANlk
 +60g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401263; x=1793006063;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t2PNbyOXM/ndjthXJH31LmTv/iGeaVm1gOF3D5tjgxA=;
 b=b1HRw+IIMly8DwocqOmVivtAt9Z5nuksdjPTXq5Td80okVfZvTJUrqtccS3/al9Yxp
 QLOYhqbys36YNfORBDd8W5boUHc6a81c5GYmWSCzGeuIqCLm+ijj9heTPbnE95L6z0I2
 im8MxcWdYYNwjpGqCh14H3OU54nkyIJmTNzz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401263; x=1793006063;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t2PNbyOXM/ndjthXJH31LmTv/iGeaVm1gOF3D5tjgxA=;
 b=zTuF5rr9RPo1hYRTbdcJ4FCuYbywRggSOQ0bWdJbsLCJEbRLQolzNofI0Dd2CSnhFO
 Q4OVYNElXvxZo7LKEYd06c90jtHTrWb8oNAbxbI5QioAtN5Rnv2/vCczJdX26pq+vH9P
 3Q+x6GR0rkFYFB+z2+Z+rmct+7YeCSjd5l9TyrBmARngk4ZUTBcdun1TzPSEsMLjvqse
 a0rWJ2INleBBi9kYJExM1leWibCBBTQP18a4OAxyviX4mWawZ0pwFJQ/5/IT1MBKMejY
 h6iJlkp3nGwDBDECobK/aBygbkda4CPXaj4ykpv7mwEFUlS4wP7UVqFHzl7V/gGANxMF
 GXqg==
X-Gm-Message-State: AFq9FYL8INjdlJq4KYNrbz2HnaON52GVUFKGVSCoIJp2UGOpmYt6+EZD
 zECG9VIIHQrZapSyuVxyx1sKqKT6FHfp9TbNvG4sJPCKJrOOBjyV6NpUhz5UjxsuG5C9DGzaTQu
 hvNqEhWggICT7tmvflIQKf0U4fkMU/VqQTLQAD2qS
X-Gm-Gg: AYBFou08n618tTnCup1bSg85i7nB26Tz7CVkBj5OKZyCZh2ityles8PgWxT+N/+KPTb
 CvwK0Ty5MQ11maK5ZQ4iorL+cla85i2eb7H/E4a5iiiSygnzq6siIarPBr3/YFBHD2gEmeyJyMv
 XddmP3+8whId2myfV+xBK1MKr3Kt8y+NXRfHR3b8hBEriZZ+1O4PUNaZKvw2wmuSJdAfEeMelF/
 uneHHsmFbZ05O5Zor0P+KDNDbbM9kOrV7uF0TBo/4NW9vDtiTiziiAiKReesskp13JgqDF9DrPK
 YZ7h3J6v/k7tokNlv0/lecFpl7Gg8LYI9ZLLx+bWuWnG6l6YqRSm0Q==
X-Received: by 2002:a17:90b:280e:b0:3ab:be66:ddbf with SMTP id
 98e67ed59e1d1-3acef58d853mr5421569a91.54.1792401262959; Mon, 19 Oct 2026
 02:14:22 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:14:02 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 07:06:58 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-5-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-5-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:14:02 +0200
X-Gm-Features: AclHuK9fVubMHmtlhoWN0VxuwWgTnMoS9mrMIbkoMT1BZaDQ3soeg0qrtBR2ONo
Message-ID: <CAFLszTiQ2mJJO1om2Hory3m78pCqFKfz6kYv7sn11zi1mYMNsw@mail.gmail.com>
Subject: Re: [PATCH 05/14] test: expo: Test menu wrap-around
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
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

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> test: expo: Test menu wrap-around
>
> Extend expo_menu_header() to check that with wrapping enabled up from
> the first selectable item goes to the last item and down from the last
> goes back to the first.
>
> Check it's also skipping the section header and that scene_menu_set_wrap()
> returns -ENOENT for an object which is not a menu.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> test/boot/expo.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
