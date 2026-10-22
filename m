Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098B606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZMRF7/Q2;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BnhGa1Hg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD8DB6081D;
	Thu, 22 Oct 2026 06:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DztUvV3g46pm; Thu, 22 Oct 2026 06:40:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAF93607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792651245;
	b=CWV/8o0Sf0CCBkNB9/mGWMULjaBgMCz+4CB1AhbfN5VBFR0I7dsjm4rfSO6JDQG9XDXC
	 C+QQDT82juG5u6s/7G9+2Fmg4o6odzRErC8oHsv0d9lpDbbnso8efBOqLxlHDW8pwV4Tg
	 DefjSSeNiPtbxYZHcfm8A0nqyQb2UNMk/QNP0zDLVECpiZjs7cacJZr+CEtyHJPdq5E5d
	 MGHSI2s7ydmVm7cGGqtYKJtdl67VtilNJC8Zc7mr6rt6ORe1pBQYLei89svSVr9CDVxdl
	 2cln8kA1kDMpk5a0C5J/Pm3KgJEQuL6Sbf5fLWwtQ9QqNWjD5ZYJall5CL5DCiL9OGg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792651245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sb9usDJDJi+Qfzp2e0fQwb4oZ0RChc/N9nlFERbfZ7E=;
	b=fZVdIiCH8SkxKo4iLWwLK8t7OOs+cZZTj4raN75Qftq6k2/ePrzykhudqlLEidZajKso
	 edaixhy9BhVp7XfpBrtDRbraRStjRSF4i2w+1CJjyPomUOJMRtsGiYaQA+YA2L6mjM4Ls
	 fEABZSouVOfspF2IeHJ0PhNNXvjVByBSAKCmcNU0DuoT12dV6l9x9NEQJQEsaAbTDRiXP
	 E45G7pggkR5w04oHHGoN99i5Hnabzb6K23kdAWomf0UxoIMeV7ovfVyQ8DOxDUNg8stsl
	 LdarYdX4XR3gjey+hwoKoRss7wbk0zEvwLWrfo4vP5dSaIkd0BeXGFQaFGkzBDPoKyQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792651245;
	bh=sb9usDJDJi+Qfzp2e0fQwb4oZ0RChc/N9nlFERbfZ7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMRF7/Q2HSti4g7Mvt48b5oPiNVMZDvZ49j5FKuEKXtqybQyka5dQjZptacic8WdQ
	 8Btvvs1GqnRq3YW6IlyAGxk754N2UD/h2wGJNQ7009k5tL1yp4eceAohlAEmZ4RHIC
	 jikpTOemfpp0FuJy61itPZPv7gRNuYlfHhGrgor/kIr5Hl/z5x362zBVg4ifg1kLx7
	 Wy8cPuktPMDHfvLZVl6iF+jgXADXKn5QzVo3c3TBfz+EuF+ien1rzXrKRPsd65SQyc
	 U7lna06hHdbIwfkz2zoTrwB10CJb4gefsPqfxML45KHXpf/zV1LC0KB3kvIzFtEvGK
	 oAkyk6JwBIzlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAF93607C4;
	Thu, 22 Oct 2026 06:40:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F8773C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 06:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA0C440075
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 06:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p4fB4F03Zoqd for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 06:40:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DF9C940042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792651243;
 b=JNeekBlnzfKLwxpWkFXWbHTCT87GdLn/ra8vvGBKVu/FiTJ+admABZN2SI5/gIFQQHDQ
 NTP19LtyIR1pZfoX4/SoAoiXlATWPiVByJZng6jwlJN3+z1TSMAAuDj0NJxJ3cROmHW3o
 QwaBX9aBDMX8mBpz+N8Npa5VFI3+IJZ/qIi9snrqWVrATwrUMPkt65pv6Ipv9EFloOonE
 glceqGCW8W/F/sdtMgJiQZ6lxYTwcFLNZuYEeG+2X8qhVPq0suify6mLJqVLzVcB8e2Td
 33Dan8YUO6/KfxbsqQQFXJK3RktCbN+DxTX7iDIMUQbHQgLyVnZVIdlgubxB5OpHq8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792651243;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=sb9usDJDJi+Qfzp2e0fQwb4oZ0RChc/N9nlFERbfZ7E=;
 b=r+jIpXDHIodVS38hkc3UYwmuLVV3cC7u8spDWlAUG4cCVddJs+QPsC0/CmQKnE/MXefv
 LitIpL5M1934jQ6i2u4tEb796nk1Q9u2F1s+Ox4d02ImRBNAp1mZ+TsRNOvdw4aFlLSQf
 bTUVC90eonB/v6DrAIT38KTL5kek0rk/O6KoeAgeB7KAdqcTBvrVBp766EPpyqL1BQis8
 dn9FJ/BKJGOhkRi6tyT96XKtc1P9RQpwt4hVe0HrftAO7SWxuwBxMhxXQ9WaWgSqL2W2k
 +bydfq1X7u/Ynnx88SGbVX4tXFi93RHVpg+anbTyuYPBGng1+cpcR4qsoT4WbPgOzbg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BnhGa1Hg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BnhGa1Hg
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF9C940042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 06:40:41 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c4301e334ceso103959666b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 23:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792651240; cv=none;
 d=google.com; s=arc-20260327;
 b=JpR0SBlb3zLBYHPxaBSxLaDA+ahDp7ZCem3r4XUFdsuO/VwZHfgwGOsacvrQwWpzFv
 /JaJ/4NyJ65b0XQs5Xl4MJbVbmHNsmILzbkkeMLAIbLdGWm6IEyZbWGa8lvbSaOSTq+c
 Ys9NtVx/MvXtqST/xJAwkjO0nSXUxc8SjWfWFfR3c4aMQTwC7N5e6hk6+yUARopQMzE7
 Gb309CjGK3R4QNYuse75A45aHFzFsXRBJZbrOqdzdW8vhVW6BX7CIylwMMbK4z6U6tmq
 JtQ/TpNG9dgwZop9wJZiQDMsqoYX7SVP3aXfuczB8X1VcjH38TktOFUXJ9XXtkoyhIP5
 ZHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sb9usDJDJi+Qfzp2e0fQwb4oZ0RChc/N9nlFERbfZ7E=;
 fh=IptsDW1RQfRCfjTwOTRrvVOacF0SB9QCUKLnhy2lLOo=;
 b=aq1o7MkGJk1uN5b7sUBYSHHGMngDUs2YKQJd6UZ2b9AvjmmLbF9dQRi2UfYUyDB4t4
 8y4lsMqdTluKsVqaOrTGGOeB4dP+n9DSwbftxBz+RWJkmARocMMQuTvPbyKic3McjD8u
 bvMMl6ulk0Zy/1fgZTCmwkF5FNGLJtC8n0dH3b+CoGuTvYl6FDrSVUlpWL5t8UxiTV2k
 kicNHnyu8E8fm6aR24rTL2JKFbSdtgukLSz/MnpoWYkXAqQQrSkbjd8rBdA/nnkh2Lep
 ffRoeG4IM1/nV+x3IGs1bq2NXrFKymAvSGbsJ5r+NpAKiZ57dHfqU5e+0I/PHsW+vY4W
 00YA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792651240; x=1793256040;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sb9usDJDJi+Qfzp2e0fQwb4oZ0RChc/N9nlFERbfZ7E=;
 b=BnhGa1HgVsf9vYRo9S4KMTvsCccdR7RIMbZu4KAxjsh3JwygpYEHbj7d1CUmoSAy7p
 izZRQt5YvUBp2fSxDY+NV6lRZtrKLRvA8o7anUYrksHeGJLTJtmCApKpibh1OiDGx4f3
 bn5SMZkRTZeBUUqXMRNGCxgJrQYIDVhF+/iK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792651240; x=1793256040;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sb9usDJDJi+Qfzp2e0fQwb4oZ0RChc/N9nlFERbfZ7E=;
 b=kbBVfNX+IZ5C7KMolGFjFRajCB6b0Pm6oE3fJURXCZpQCvRHKFFoB/N5FlHw98V1pN
 kREG6kcVxyEYEh7woHAudvL6xmqvBrHlmwkiMZ3cE3/j638g0szLnpCZRWr7QWqMg44R
 8BbchRJhSSq1KCrqlQweuwXyxvRR7CwXZLTUB5A/ZNTpc6CyDDhgOHdnsuGwZXf+FFWA
 ZT9qab2NY6CJt09vWUoNvlGOvDigqym0Ugh/xk1eh9rrP8jftOwMg2fbaoZDrLG9Vbkp
 zS13gQ/2XxbtY05ySdaGJyahUO3oUTMep8ObcLyg92EPdgJAf0rpG/bEyPJmDEYgbcDv
 NIsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzc1pV38tGwhIMNLha80+CoEb2sJGmoJGOtiSSYNIH/cewOV2u4ANId1M2AoQa4HI/P8HNz/Pk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLzzt7XeRerCT1TpN78cEa+wi4RfrVf4Xv6/EjmnjLTk9q/KcW/
 CU4AIW1X4Feu2ndqaVQLmwd/6qIBlzoFZkqf5QhPaT1p+ijXR0WSlFK+giMFooXheCiry9t0swX
 MT4ovBu038PBPtYlkUoBc7fJyj+ZJvdt9/7IsOXL/
X-Gm-Gg: AYBFou15/SfcSBkcv9GBWHEibYtQ2yZat1TJqE9HPSDyPIm8zpD3bO0zstbZRuzT01Z
 Nv6EzggUKWGTao19kLYiiwEj6Yz4zwC0Tu4S8TzUaQgTMoK5AWFxY0AFNYUz/lwBe/9ik5tM4wk
 +lnRSbOcEoPhyz8HJsYws73S1fheM2wcpKY6j+BqGA6NqkEodigd9E3B+YPPG9gWRFRo/oW7tC5
 XmkElmQTqq11UsvCH4xXkmn8y+yUeqhTLNFNfHlLfE+s8wrzoRroaZd3aIhesLrms72zyB49kdG
 vMxNNYViom6pIt583UWcj1kOpfEcEjOcGy4JNr2bB0UfvygBy1tWCPJOU2MNJb835+mVjYdnCOl
 OpWsV8DtOfHzUsubc0fZCi2ujJlPtgocQEBbwiJ1ol6gNy3W1Z/TFMDdM
X-Received: by 2002:a17:906:9f90:b0:c46:7645:86c with SMTP id
 a640c23a62f3a-c4679b9cba3mr393106666b.47.1792651239568; Wed, 21 Oct 2026
 23:40:39 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
 <CAFLszTiJnwq2M+LxQ-Mp3-2hwQQ1xegni7fydb2rdVHVxas11g@mail.gmail.com>
 <20261021182134.GI3275858@bill-the-cat>
In-Reply-To: <20261021182134.GI3275858@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 07:40:27 +0100
X-Gm-Features: AclHuK9de7FDDjHvNwv6gsGTuunlq0hYAY1v-zdDFdAwWoIB2s3kyMUNXgt3R5Q
Message-ID: <CAFLszThp_5RJrzgHUkn18mB49Xp1=5B1mjCgFu331VYCnKDwnQ@mail.gmail.com>
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
To: Tom Rini <trini@konsulko.com>
Cc: suraj.hanumantkakade@amd.com, u-boot@lists.u-boot-project.org, 
 michal.simek@amd.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 19:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 21, 2026 at 12:43:16PM +0000, Simon Glass wrote:
> > Hi Suraj,
> >
> > On 2026-08-24T04:47:18, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:
>
> Simon, please fix your tooling so you stop replying to very old patches.
> This is on version 3, which was posted less than a week ago.

I wish I could blame tooling, but this was my trying to catch up on
some old reviews and not seeing the latest thread. I've added a way
for the tooling to help, though. I hope this will be the last of it.


- Simon
