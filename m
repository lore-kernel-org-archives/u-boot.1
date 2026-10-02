Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EEECA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B354480F1B;
	Fri,  2 Oct 2026 13:57:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jMUdryon0l2O; Fri,  2 Oct 2026 13:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA10580D7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949442;
	b=HM+mDuMzSvyXVE6+v9b4PvMoLJZbrwu720wvE1tNoekDNrwWYCR90Ug9KuZ9l6rIWT+7
	 Lhi6iLIw97PcEHCAjZFxSe4Mw9eIbEVzJJbl1Uk/CrXSpYrFI05nDX1S2vtT+JM/6uWo6
	 M+NEwrDnzRM4dmHL9DuMr+hHEMalk7bDQi8ju60vOPCzqeY6MKlBzMzidSijBlb5+G5wC
	 B2NZBVooRxMUg1chmh2sKlkhO39wut0gbp72lYEbdGp8lR6TpQz1dLtyH4bH7oUHjPn0c
	 Uw2J4BRTDZ7Z2MZ94eWhEP0UtEaK1eMXU13x2axMMt+cnCuXyQJEmlWY8MnhbcnPzkA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949442;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kRHpvJZQXMxj9XfjhCFb6FSxZC/AK1lf9G0WCfcvFXQ=;
	b=Vhq+dE8ZPxjC0VSVYNHSxJWQKY/4k4fxpqQ46u3vusbz4GEhZGIQ6P9dIuCbdwoATMqZ
	 qz/tCTAU4/ExAyEqKnTuGh0TwdoOU8uOKCH6XlzQxaCkWgTmS8Hf3nGw0XMMJjIyH0HpY
	 QjxeGMCRZaoSorbP7WmPRU4Ra6fZQXpYwmBVLAv3y9WCnlAn3OKNf9Akoydz9R1cXJ/NV
	 yk6OfCz6Wl/+2bhmfTRt3KhP/J1Ks69LGXNJMTXT/8DTUwy284Pn5EtfpdqnUvSZqqo58
	 7ZrUCe6uiYTaaWCboHr047lzchPMPZUyWD+AL3nqTIZ1Aof9TCXdIyib5nvAdd7ZSbg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WMRsCDuu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949441;
	bh=kRHpvJZQXMxj9XfjhCFb6FSxZC/AK1lf9G0WCfcvFXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FMGcLS/AS73atrpvurTvho69RbqxTL3qNDOSneWiISlKfjNrEHdjh017vjvOWs3qo
	 0NvrcpZYcY7boL1iO0jKijitov7fLekcgLhCfCRyw21H639czielMSctST2ieCKPnO
	 1K5sr2Wn7QzeE2qJ76Ua41eYJTGZ9uy2HPZR+q3urIbGlNzv3q81Qth+Dd1W/xKJ7N
	 IiH9nKIGW0pfwo+/9B1g5+dehRvW0Ue5i3QyKrvYdhr9EdNp9/VF36n1dcPnwUst8C
	 SvtuhqHG/AhnjI+o9GCLuzOZuUURvQ8drxVuZ8mM8e3D91j9AOLk4MDK5NwG2RFT/P
	 RVSrtqrf2oqbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA10580D7B;
	Fri,  2 Oct 2026 13:57:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A88A4435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EFC180D7B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:57:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9q0pKv5JCYY for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:57:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 75C7080BE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949438;
 b=LDCP5PSEg0rdzE42xdD28bRjsqCa4ViSBwstFg+FpaUueos8SOZlRReEGlYhrumCPmdC
 wPh5UMEfqWYuEnGHrWChPVjrggh+ouCsk1LQcAZmxrNZISaUUZ1iB6Vs5ZpzWYJdjVwD0
 21PqWex0RT4qMkNvBvFUKFiecYkzny1jVxsOypCTB/k2n3Mdg+nmVQHR0GgpmDZI54cnt
 p/zDeAQzY0P6w5ir7k+SYp5h0kYVCM4mlvqi/Rdog16Sh1YDThvinPuN6U+2gPVXYM89E
 D1cCxSf0i4MzcAuXefprTp/m0ORUIZwVwzEoa92U6LhkYSFkOpkILHcUCZSn+Cj035Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949438;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=kRHpvJZQXMxj9XfjhCFb6FSxZC/AK1lf9G0WCfcvFXQ=;
 b=rWnFky7cB9hB/kUvXkwAhZW3Ys3JTKOcJMZNdUBjzFWGpEtF0ygQpMvHdIDpFownIH7h
 /xNaK/xKx5eZ3ey1uXKs5ULT3IrCbMJt9/Z3j1cPu1I8eyLst54qZuR3AkakqU1euFM+x
 wlVUwcQSPlltIwcnrNoRWKRhUnKdikD9X4OZMqfhdFV9Co+3W51I13MavwZiiUfg8QER2
 VNxmKDaXs809ahQxasV0dlCsXqf03QDS5gbKZ5v8yjqHKZlGTdIapjr1FaYqvjM8Xj98/
 ETY+Vffnn2KA6DEUZFAcXbS5+0bTSnKMslaH0g7vYLtevTJHKOE6aKq9x6eAt5OxJ3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WMRsCDuu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WMRsCDuu
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75C7080BE7
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:57:17 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5bb79ea1170so1393609e87.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790949435; cv=none;
 d=google.com; s=arc-20260327;
 b=DTKlb0OqNV6f0vqv0O+3XibNaPnoNza1nFNCaAhTz3xWuZANIxIw3V4gfwH9GvFlW8
 pW0jrQ4eZ4E0bE/pkT3fct832K8eTSCgGmkxwHkyc1uuKbw7Wskhbu+9sBWS4g0lEae8
 BsdoG+JCbR8EcvFeVL0gDukVVszMF1xBWsTnqmS+kyZaTDjGFUjMFozn+9aSiE2XZ/rV
 s86f8pAuzyHo8hQMtNn0RCSFSP6mivj+o2D5g/vgnUxBe+Q3vK73cGK2fO6i9dAs8AZK
 lOlxj7ck0wKketQb6ng8GeJpXB1pk1PhIJSare/BEbEkctdg/aAyPaddr6bv4/k+PqLA
 LkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kRHpvJZQXMxj9XfjhCFb6FSxZC/AK1lf9G0WCfcvFXQ=;
 fh=vQXNbsUxXsbV0ZhpL6BwMW6mhZXZ3Ngq3D0Eklk3XUE=;
 b=WY58GnGnzyfUeXG4N6t/9nNG76mwIVkXxhA+Wz+s7jFCubIQW1pRtJVfY4CH4RF/bn
 ZdYHoIwA6167MBo4qUP4WdBtqbiirVkX6qVxjz/7NciJ0INyGAgT2LWt4l7ApTQczFk0
 3BPDN0efznYQL3zLZc3Q91lFkbVa+SiKH2qn5y7lqAZfxzkkt2WyKkqkgZ6Y/DngINtg
 C9ahLhkdhMhlja660m+/BqraFX5I/dJz/xvVk9yQVGiqWpUlxPpDm6J2QAeGPGA0IY0z
 40SjfVQYSGRBBKXSgs4LgUy5bvFLcsXxZsVWhG/wbKyjh9pCUgfYuqtl32zcmae6O9EJ
 Y+UA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790949435; x=1791554235;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kRHpvJZQXMxj9XfjhCFb6FSxZC/AK1lf9G0WCfcvFXQ=;
 b=WMRsCDuujeKer1vk8KhHN842gEVjYW+OXMXNzjVMF8RefwEB+PtmEse8HJ5cdzk5xU
 e2WQmtDVmNEoFSJMJ7pWwWItiGhRjnb+BSYtZKeO3YqZKXDkDVMqPqMQjrdHNC1vwl0z
 EvjF0bRcUE2tTG12f5vjIhvROYJxzX7XGiD9zLmvBpsXqAcyeDuWQEryqLDwFnb8kyyM
 AzpmufXdYxv4bYmlJR8HVjdfuaWlNG/VJe6XQAUi6wl8ScevL139oKK5xhude8uFwUw8
 jajUM20KLNcowyl/lLTZXc7rHMnqLNQvZJMcgL7oS4suTuwwctp3LKX589jI2eQ8MldI
 2Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949435; x=1791554235;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kRHpvJZQXMxj9XfjhCFb6FSxZC/AK1lf9G0WCfcvFXQ=;
 b=Ygf6QIYxclCyoWFiqWcqdkJ7jkRlT94ZEZAktdovLNtB9QzIuoLzcbymKt9KgJ4jYE
 eLcWqiPKfZ13DvFFQhdMPmqiyUARw7EFO4XHHqL2NTUJSNN3H6ELLOjtc85X0SvbI7wp
 l4vWscv2O4DI+xIF3wkLNb7ItLXCY8zfV9LONmTg1TXv4LeQ2ld/wARbphsOALoxczKX
 sbYsaP7DI4KedgCjjogBxsILxLcLkMpA3e77ZiuSnsX3CuiagiPiayJiyYH24povHCd6
 9uC1QcN+hRbJch9R1YdXv2hJ68YXbGqIppDj9KdlNu6xtaXD6R2uh8aiMgrDg2cLK0TM
 Kfww==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvNgaCtxZiDXW8jn2FMPydjLsH1jYcyhCzKUkarnt9PaN/KXID6/vJnkcml5yXoPU42XLyw3w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLtWNYyI1gXMRvLPw+v+3vywPuzpdRXlcBkPU15mL6dYkoBOMhd
 z5w88bpH9bunifxwJhgAtO5HyhThwO1jpo3FtiTc+P87feFQG9yX3d93o4GYucw52xfI0ujvTBg
 zc9q7an+zqw5rODaQk/r6eKjI6mEis5Y=
X-Gm-Gg: AYBFou2dAE7fL3lgvZLNNMJofBHtYMQSPwZnjS0vVev9A+0A+GZoFjtHG1mlNCh76yj
 BGEV5LjpAQvWK+MOariOaoHbUkHQ89bxGenTslslluehWRROC3SMTGiBgmQ9TKjsqbHu/TKlHr6
 108ra/D/VorLLBLW6LB/ZhURz6A1ufeT8dIxK4AD2HwTjwckW0/Dry8jc5RTXnp9BWikAfXrK6g
 +c/ToKNjWW4te3f+IiwDlBmaiR6z3vkk13y0KJF7phg4qWiKgalXIMxEtxrxBNkb1ff4B4787sn
 f/W7Q8gsXP0EwC8gwTAt72IJNcdlLH+w9gLKwLAo84M1d74jluqdNKiOrfCzzvH5Sw5SNEVmjyq
 H7oJS+aOMB7wi2Uisi64oeOWv219EokEy551POn1U7sI=
X-Received: by 2002:a05:6512:66c6:10b0:5ba:43d9:8c31 with SMTP id
 2adb3069b0e04-5bb93a3934bmr797302e87.20.1790949435238; Fri, 02 Oct 2026
 06:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260929125203.592014-1-mwalle@kernel.org>
In-Reply-To: <20260929125203.592014-1-mwalle@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Oct 2026 10:57:03 -0300
X-Gm-Features: AclHuK_Aj_3gGcF6iRXrHa0yMqGPGWpmbJZ22_-4jhA4bv72mKcD0YDlZNd7Ons
Message-ID: <CAOMZO5BV--oNMGVC6fwy7kYAsws5L_Ddud5wGwrHweT+zanK8w@mail.gmail.com>
Subject: Re: [PATCH RESEND v4] binman: imx9image: respect BINMAN_INDIRS for
 external files
To: Michael Walle <mwalle@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michael,

On Tue, Sep 29, 2026 at 9:53=E2=80=AFAM Michael Walle <mwalle@kernel.org> w=
rote:
>
> We have the BINMAN_INDIRS for any external binaries, so they don't have
> to be copied into the source/build directory of u-boot. This is
> especially important for image builders like buildroot.
>
> Use the get_input_filename() helper which will also look up the paths in
> BINMAN_INDIRS. The append case only handle external files, thus we can
> use that helper unconditionally.
>
> While at it, update and extend the test case for this image format.
> That is, first create the image in the input directory and then check if
> there is actually an append comand with that image name in the resulting
> .cfgout file.

CI complains that some tests are missed:

tools/binman/etype/nxp_imx9image.py                        51      2    96%

https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/jobs/104929

Please fix and resend.
