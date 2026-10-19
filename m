Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2667607DC5E
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nCWpVGgU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ku0UD0Y5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE2D1405F8;
	Mon, 19 Oct 2026 14:56:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKxCKXBlc_vD; Mon, 19 Oct 2026 14:56:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41F03405FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792421802;
	b=mgMNorSkgXT10rQmRfQT1ZTfeuA8f4ZBPEUFkA8mte9jrQbFcrTBSrTMn/B9wSqNA3UB
	 wlPHxsn4dLdqb9biPxFjUO/BmEHYXXt4SktbCjr+ANIYM0pop2q8vsrgh4GEAkinzsFUn
	 4930WXrjKqBLSuA53N2UC1rGZPD4APH43hplrJcO0B2pneHioY/2LW7HILrhqW9bdy+py
	 0MtOcfzyYObYlHuJwkwEnS3Dqhs84jHZ2CBz3T+UU7NdMMhMGHyf1vgFvqqiKrg6CdWW2
	 GIfQvlGawqvxv1gLqXXmi2ahr/w3eudq3tMO1GUTTdd4xW1JjssMKVe94Ih/znhJRnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792421802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ao2E3X9qw73q1LvePHqA7TCebIdBE3HQRc6l1RT2BS0=;
	b=SLY+I5iGge5/9t/pyuldFFuEBQAk1qE1rxe7iuWrMBk/Q3JjFWxhNx7gi9wCKa8GTkSi
	 edzhuhR5AJuFKHIUu+8Ed3KwlvHLYYq1tL4CuM0wxHUWvYvO9TexuGzFAAX/BgBOUjUUU
	 AV5UWvrAljz2QbPIipdLrLIIluiCiyyw3vrUksn+wzes8syFiBX5L/qixnhWlZrO1PICR
	 UrgVa7mRBMy/f3DnXSMuh0BYqOaFlWhRf2CpqQvp1diAQfk3RfANYOsSHT3GF/X4XaN/L
	 tBFIIyOzTXy8+zAvmO9EAw8Ca5yeNt7n/iYJd6CZ5/VZKoWCYTXCkX7IolYLJcgUN6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792421802;
	bh=ao2E3X9qw73q1LvePHqA7TCebIdBE3HQRc6l1RT2BS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCWpVGgUjPuKgt8GI+HvqDXcHG5rSScowzzxsBs1jXJlZpKbGGuBos43OGe7W+aL8
	 MWc6DCdjlxpc8qQXDa/pvQi+1Psz8ajEzv2rsr746cGqDyZ46Sxg6MPNPGZzGlmN+D
	 RhnHFyxJeM/dAshV/nFsJ8FtSEupsNOIzv0ybchO9rWv37Dq8JC3EQ/zCQI1CjWQxB
	 ZpyB7W9FBHrWVBDDw5WxToZkC4M20WNLgLTM7Y+ZQxuTFNwpNFo82hL48GAqnqf8tK
	 VBh2R+q/J2q62bdyjmuXECuzhK5vjDJrVPnclZz9/L+lRX7fLCKoU2Zcl7yxIpFnhg
	 M+ezYe52qO6Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41F03405FF;
	Mon, 19 Oct 2026 14:56:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AC77323F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E1A680DA2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zuQC4ZXFNeZf for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:32:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F393680D56
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792416720;
 b=oKrLqXSYpG3aewgLCc8UkSiTcObNSAS7Jurx6OARTc+4R9E74r2AP3AAELe8BUGJnrHi
 /vMPzcNyxv2MrX9DPS8I1cFsWLizcxMGqa0KYnBmO0v6WlJG3aq7mH42E35HTPHnd2JQ/
 X0dtLkEv+Hnk0lWmel4/+/fGFuG9Vj4HUGAzogiEnujoOh2FdHdjUIF4yh2MUFaxHLXMc
 ZgyOcJQlq40+t3w6pqRPz75uHZEBo1MSAxeo3Li74/edmeXMWVNH4GSuMaus+Awg1c6tO
 AfXz4t1B42LfVwmGGFX4bL7J73zCebbi8xzaZ/7NC8r11LVk/jVnTDo7VwsvGr4JYOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416720;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=ao2E3X9qw73q1LvePHqA7TCebIdBE3HQRc6l1RT2BS0=;
 b=CyMrnaHyswN5Ogi6hCHeF2K1CFefe0kZ/2HACNY2wuQK9sea9lCzcF06lVjHpK7pQDUp
 8FasGNlJblfqsU6phHOMEGeFLO2m5R3paLV3Ce9XlxoyzA59mLHcdqYWDxCdydR9em7Gm
 8+TTg9nuJ7D0gS4IOzyiR+VjT1YPq5VFWYw1rA3MglJQ6NJuFo0Q1msN9A31t4kMPBetv
 1cNN1Tdkzosn1NsjXgMVbCalu8VRuSwXk/9BYCThYsCwbk5QCPAqxUPknWfrP4FGog8F+
 IKuz2ZBqMJEt3PbqHWfuI1F0Zw+tGs/ARz33PmfIdskVTI3k3XZTfQQov8N3FeSs6Nw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ku0UD0Y5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a32; helo=mail-vk1-xa32.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ku0UD0Y5
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F393680D56
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:31:59 +0000 (UTC)
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5e941201909so630310e0c.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792416718; x=1793021518;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ao2E3X9qw73q1LvePHqA7TCebIdBE3HQRc6l1RT2BS0=;
 b=ku0UD0Y5sBHJiKroIgjRdgdnKiLZAy7skoZtpdCs3/2YzM26Sw4suTM2ScfVGZaEfW
 a0c4ZP5ayfAHvrkjUJAbd2EWviUIti9H4BIUi5srUREwqfgv65oVCRySsY0t5s4FJIaI
 EBsn9U4/ibJHC0O7wu0S7w86McCS+IG3rnA5fEfVNhZl708e5ZdC8n8naoeJxsB7JAP+
 yxfXvpBYA8l4zBHsF5C69P16vjih6KXdXONRB0sNhu14OOkTs45tJrLPaFRrlXf2+5DK
 skZT4o868P+SG1Ni2DW00f+AW4FztaBSUfWQsV1wJFk4i+U4xsCUuJBJb5QtIFFzuXgF
 vkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416718; x=1793021518;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ao2E3X9qw73q1LvePHqA7TCebIdBE3HQRc6l1RT2BS0=;
 b=VWUDnIr33UjaSd06bcEwqfQgmADU5c1HNVYsb5lmsO1uy4gJryhpuW7B2mioAO6uXb
 cfpfF5grHozKwvolvxHCWQceY7GXZH6OppYBMHuEiNL2mWIpSQBLZV/LAnuJiw/q1+fr
 d3kGYf5Dx4vkPEY6s1OQLLko17TrcA/BN68BtdjWN8nswIzNdVbvPzuJ7gm6oDoZQpJi
 IVWksRV5w71U5SdQr05uuww5NzGfc8zwZzcRxwRHVsl/8LJO3hnFCpGNoxf4Yp+Ia0Tx
 u2N03pvdwch0GzpY1tMU9yNLj7ssfaceUGXIFwWx+dchfYvz1YnWu3r0WC9/RsiLnEyR
 iSlQ==
X-Gm-Message-State: AFq9FYJaejs2fccMTutUCJz9NPfVL3Pc+n8z+BfAO6NnqNzSpoCHGmKj
 F8BGkDRONrLvlLhkSrGTr5lkV99P8iYnVioEKHcjR+JlVch8nVnKI2rG
X-Gm-Gg: AYBFou1786Zon+Pzw2oPPabND3kcU7fpqaY4Q5o8XXJL/wz6/XCwxHDDkK9JelVbj0t
 kL3j2KacmhNme1y7CrmGX2JgTh1417Dqyo2n21i1degQglSpYbMnaZjxHn56rEgp9AfI07/otGq
 cOBBZlxx8J53OO12hVYA57Evp8Bkj7yD7l56Qo+/gh4+CUhHgslcrhzFcwGpHj3syu0ZM+XKOON
 kV/6jTet4KKdHTDSdqbrq2PZ+kIR4kApBldYt96cuvBh2NVZ2zmTy7hPwBpX257Y2n2HLXxnlm7
 Nbx9Dzp2JTf+/SrESI0+cf01hGXgX8rCQ2kH55faWwr6GR84FTkU/OlUqf6pwi6unaEO+TBKoxz
 4S5akEHv8RcDnbu5YZnqyFh2z4PnrJuY0UJxaX4ibdSZ3TYeS7Uzi8D95RVUKdXmtsL2cS29Xb2
 thS+Ree63fL3pFb3YmVorLcj3y7/kgMb4+IJPGD+rhgsJtsdhYk6kTz2UbrqszABJWqQuMfOyKN
 If/TN0mQioXlw==
X-Received: by 2002:a05:6122:e462:b0:5ea:d14a:ef8f with SMTP id
 71dfb90a1353d-5ead14af064mr479432e0c.4.1792416718387; 
 Mon, 19 Oct 2026 06:31:58 -0700 (PDT)
Received: from jpg-duosnb ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990bb334decsm140859241.4.2026.10.19.06.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:31:57 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:31:51 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>,
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>
Subject: Re: [PATCH 4/4] board: sophgo: Add support for Milk-V Duo S
Message-ID: <atYbKddK-LBPPBhZ@jpg-duosnb>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
 <20261016-upstream-v1-milk-duo-s-v1-4-e4bf386eea2d@gmail.com>
 <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
X-Mailman-Approved-At: Mon, 19 Oct 2026 14:56:40 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E Shattow,

Thanks for the review!

I agree with Yao and Hiago. The sys prompt, build steps and
documentation match the existing milkv_duo and milkv_duo_256m support,
so I'd like to keep the Duo S the same (at least for this series). If
any of these changes are needed now, I will send a v2.

I also agree that better documentation for the OpenSBI version
requirement, the FSBL and fip.bin (with links to the vendor sources) is
needed, but that applies to all the Sophgo boards. I can send it as a
separate series later if the maintainers agree.

> -E Shattow

Best regards,
João Paulo Gonçalves
