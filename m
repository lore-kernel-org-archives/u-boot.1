Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AA60711CC
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XFwvFmlM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0q4/yeG9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 218BE80E03;
	Tue,  3 Nov 2026 10:46:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RXOBIyYxb_9H; Tue,  3 Nov 2026 10:46:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 168A780D8B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702773;
	b=gzQKjH34r/GB//YU8Z6wvpci5EsSEa2Ux7PaaREWeUJmsHvOxdp3n8YZsmOf4JTCa4do
	 HEzUkf1qlvl9B4DXPbsyxy6pYEZdEuxSh2mDYT1vvITkciafQgG+NEDZrKEQjFa3uJtLE
	 iu9izpXumrHPRupt2pZcp6sbTGBZerb6S1doL/NuW9cGrjbwP+jzsEV4bk92gdEOdcfHA
	 5/ksDOSWnWdpyOOmuD6CBK8U5YMV2LSlN8s6R7ByQ/mCe43gSnj1Wejo8TEHAMZaS1SxQ
	 CMqm31EY/mVNbvIq3PEsyV3+qPAp+TSSe9DQw49pxtuYireF5khOL8K2v9CXx5XNBAA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793702773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+GxxRa8b3Vcd2b3jmCiq+IyLFGxtOEka5ZNppU4p9IY=;
	b=D+D8piMD0BBpCazdfJJTo9WYjiaUeze3B1UUEnpf76PSc75jax17XTmrFKwLlOk0Q2lR
	 JRC7q6MLB6bhMKORmDUBeNbV0x39yCKy1k5GQALNmCSYSD3dwBUPg1KRELcmk0PU50k+7
	 5/+Z1q5fHxLU0z289PiYDLvGbBUhjwyZVhDwFf2owR3UCNm2VdfJ8vvJoDIZ9Lzm3+EWX
	 o3lkQHN5uSBKwNwATTb6fUTpjg0G7qOcslnQR5HgQv2DVdQ+tkfQg9Vr+0wgDYOXhO4RL
	 /F7Iu6k2Z492VRSDUhv4TQE7kke8SOMxn0oUXMrXulFTMMp4ycsmZyqFG+a5CLR/PvA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0q4/yeG9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793702773;
	bh=+GxxRa8b3Vcd2b3jmCiq+IyLFGxtOEka5ZNppU4p9IY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XFwvFmlMd4wwcQCr4vDtpXuT4BKFZ7pB5ogHX+0XjlcZK6ebOrQ0UFyPTgjg221nt
	 gtlfpC2nzOp5jbofKRaMI6ruCqNO4r1n6jP82u7X9+T73rwzj+BT8C4350kPqSUw6T
	 PBVqUvZxsgRAxE7y1Vqzn3tQt/IDPsqBHnBVpCDH15N4lA5meXkMfBfSKK++UwdFYo
	 USuVM+cHbmkdTMB47jnk5C7TvXO8QaxZxHf/kcTSmXoZpZjXFXOGOi2Q/9CwNoMdfA
	 Ohsl4Yu5EfJ5JYHc77OcqhoyT7C10bem/+PJO7OrwkEZk81MSf32gDeuntAy+Gptwf
	 9IjlJ7GZV3cDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 168A780D8B;
	Tue,  3 Nov 2026 10:46:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 689832A8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BB7E80D8B
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X1cbHgtvK_3G for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:46:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3811580D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f31"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702771;
 b=svc0CN9wTUJEj1OaaU6Y4275Ve8ldQ3wZsYE5J37mEh1yKquQHtDqazEd1EHMCp9Rajz
 fhgFOoa6TcfbXn06yMTkTaZpkMlC+W7/Q7mPBhyagaLmD+0vfAogttjgVDk8Rku3o5jxE
 sBdjBUYw8RHyPHNwd8H/1D5XmBI4UkbSyB+sSzcl7ZDAybmpQYkfxXs6xp7mwVa/ThmLr
 aMXMbp53j0mMv33O8+wR1lWFHklollEIKqDCYzHlT/L35kV5mpa30hGMx4HMY0JfRD2mr
 fgfA+9w96lMv5pVMcEzLY3VD8OBifuXw4pFdJ7aMeONpiHPhBq2av69qIc3gXLBaypA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702771;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=+GxxRa8b3Vcd2b3jmCiq+IyLFGxtOEka5ZNppU4p9IY=;
 b=LbSru/ySqruL7Vaq4A/pd+zS/6Pq8vMIEu+LNUVBrylt8V9AgpAYoHO9CLh2aHNB/PC0
 orn5Ac6HeVPFZrup7T5fQYJCmXem2R5i6lt6fytvDMTD+ycTQSgPzHpiAhNMLcqXIArqh
 MG3nHcbI+ic+uhANTcMvpBT4pMA+LEBE2Ik4Mm99EZrtjQ8HlR1UKFC+pWTkpqVFoD6Ys
 UqagHx4JCaW2iCQCLDRTilJq2TLHHvy32dHwSVOZiMonJKPnL/VJhUAjOmLhbSYG9Rpnl
 YuWXD5DeNvN8k8ilCG7mOrlDRWRnM8YqhyX9uT6D6J0mk0UHE6PT2VuiAeiz0Pg+Jww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="0q4/yeG9"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=0q4/yeG9
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3811580D6F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:46:10 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-91c67992ce5so30392586d6.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 02:46:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793702769; cv=none;
 d=google.com; s=arc-20260327;
 b=CcA0fGV6uNW/4BN1VQn0iVlgXXUgw3Ye2GwS9iMJb8qCXNq5MwAvSCDOqwUzYQimZD
 No/+k1oHUK9UTwZosOuiYiwJ8aSBk6ncvq4B24k80Ka3uNtnsfjyGPG44rwVSpKN+r5I
 1vnedieJKAOjl3p92xRIyZ7NSdSXhMZGUAz6/ObEWryvcCZHnRumSaEvsvVM5aJMRmZM
 Hgu5BwNz7HYgXoqPuFY50FMyPvMUyVNndlJ2lsWGiResBs4cdstncbSPF1RDuzb4bb1v
 C3byXmNRWazvqDZUqoZ98W4IQw/JTRTz++Ofq+HLZaliKEdTH+IBXEpHS8xJB5BjCVWb
 HZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+GxxRa8b3Vcd2b3jmCiq+IyLFGxtOEka5ZNppU4p9IY=;
 fh=KUnNA5Hp65+/L7wJUVJdjhQJ3XgaP/jZ0OPBUqBQzkM=;
 b=Dcnw4TRQ+kQGlJqAviQUFGYzy49+BUm/f5jmFc6fvd/eUx/sVfMz7wSEQYu3AxbXpC
 dT4TYNd0G3kxTO0GJ+tXGHxkcaz8/De7XB4Un2INvmzkmoxucCMSzHnH3NGZCMJQ8OQ+
 iDL0248RTl/fMI19TuSJxc1wUwaVlBcXCPwIqA/k84b9Bd4APRE2jOe+FNBfeYngrhn9
 qxYhD2luZwMkHC8jsmMlSy/D2VyuYOjnRfUNJvzybk8A4lsmL/aSj645BewOUM1OFhzO
 iak5hrrhOD1I4o9VY4Nv0xcDMo4EzEKPE4KFa8poNwtFd7i0dmBTGXGjGL4MXqKANc7I
 SucA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793702769; x=1794307569;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+GxxRa8b3Vcd2b3jmCiq+IyLFGxtOEka5ZNppU4p9IY=;
 b=0q4/yeG9jCy8RjydPKxTOuBCuE3ydr9wO7Fyjfq18lPW3vT+qmn3n6wCXdrgTglkHQ
 TtTpxKReAkJJhOx1R0JNyIoLrwuBPoUcjVSJd+hkgIs/eL8b1w5mughW8gJu97JbGUPC
 D3ZI9e488kqveTwyAb35L5Q3iGObg3+mnhX/usVzLXX7jpuEpTtY74PjHk0ElQTNlxJL
 /GM/4h/6x2mac9t9p334ebsIeRJCMJ9JCFhaEfRmBb9Eh+bv7Ug3MMkGCHMQpKFbtHRo
 q0xuzfzqZmcoJJr1bykckjl5Zj8+HsAj9E0eGN760RHx3hKFAMTmlNpXEs4u3L48vGm/
 fqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793702769; x=1794307569;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+GxxRa8b3Vcd2b3jmCiq+IyLFGxtOEka5ZNppU4p9IY=;
 b=vbuALqSwmnh6ZnkiyJck2Phf/jMjoDbEp/Zp1xHqAUHasvTVfl+5nSbMV5cnRJugqi
 iR44nYrRoIjAF5j1dlVqBYLlmMacqWESeRm6deadRaIotsbr8rz4NKQFC63DvnwBbWEn
 0MCSy715zenh6eZawJoe3MsIRuRMW4OeMMigH8gqjMR3rdyMxg+c3MerHjJJreQsPiFJ
 rUn4QWJCEsBnX7TVNskwbF6dFJsVhANv/8bG9ssVmDilDGLRHfqOIIb03kgoC7ak47Ts
 QCMN5cwt5Rbeh0xCUUblOoC85VQTjy9QGgrAIFuBGzV2L+3mmMq2Q/bBLk32vxOP++6y
 mqzw==
X-Gm-Message-State: APuU4Z943awbv5Ql97D0Q2b7QlGS7X3novX9APacbxMmSGZOWktWhSmm
 Qf+uXxfq8DVECm2InwPl2TpyqHqgNuaCsJm+RmUidtjcclUribK11kwZVcgNKtKJQR/GaBtYd/Q
 tjRam2e3rys7X7StubqwmTYBXLFVdcMvG+gc5JHI=
X-Gm-Gg: AYBFou3c4ZLoOq838x4RrvNQISLZ6HfnqKW+X9YsfrtXsux0FX2EOCVA9uh0PK6KbOT
 IQMoaa1QHs6nQBA1ds5SnX6ak4H9oybr5lyy1/UbL6jhJlJ9czATK38+R4boKMe7EHpCPZENGIv
 mAfpbD5pfloCznusXwrmdcPr9Z1jfezLQYLkYGps1XsRYoqtoLEegU9vaeAKgChRRY7iw6c6vlz
 dt5pjqMK5t0xZW8qJ0xpWAvTHmRfk0Uq2MG0U2HHy4S0+2TcDfAhZifwpeH/pubyIGccTkOADWh
 4AYCfHDUPBtuIcjURfIENy9xJlID/tLkCBO+NkjLYhpZxiyWC0jL8sj2TOQ1FUKPBAVHOTJd/MY
 O7+COImjtEI1/n8Hm527UAoETuwXTjYi183FsoDmWbUkU5g54wQJOeC1fW+2sEIhktAtLdNldUK
 Ws2jBPRav8Xfti8rJgrJnjya90JISVXR86xq2V9RJ7tVPcKqUbyW0joELMFiA2HfLybinvHRFiE
 VfFCKW8eX3tPGXO4P5nPeJp4eUsTXd2zS+i4UY3M3+opRSwxqnf6FVI
X-Received: by 2002:a05:6214:3ca0:b0:91c:6f32:294b with SMTP id
 6a1803df08f44-91ca4b94fc5mr200308016d6.44.1793702769125; Tue, 03 Nov 2026
 02:46:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <019f9483-9642-4d3a-b27d-a0e80c131193@tu-dortmund.de>
In-Reply-To: <019f9483-9642-4d3a-b27d-a0e80c131193@tu-dortmund.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 3 Nov 2026 10:45:55 +0000
X-Gm-Features: AclHuK8e726Qke0ULp8GP75A3OlMCD0sweLnKuJLOL7vCWogjkzsRx-oCc-3T3U
Message-ID: <CALeDE9PenKScqu3i6How0G8=RWO77YryWBcsT7gc_zkU3DSHjw@mail.gmail.com>
Subject: Re: [PATCH] bcmgenet: Reset the PHY of Raspberry Pi
To: =?UTF-8?Q?Andr=C3=A9_Althaus?= <andre.althaus@tu-dortmund.de>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andr=C3=A9,

Sorry for the delay on this.

> The Raspberry Pi firmware supports netbooting via tftp.
> When U-Boot is run this way as the kernel, the network in U-Boot
> is unstable resulting in multiple DHCP retries (sometimes no IP at all)
> and timeouts during U-Boots tftp transfers.
>
> It seems that the firmware does not completely reset the PHY and when
> U-Boot configures it, some settings are not correct.
> Reset the phy via phy_reset() during the bcmgenet_phy_init() call.

You've also sent a different patch [1] which appears to achieve the
same thing. Are the both needed? Is one better than the other? It
seems this is the cleaner mechanism but some more details would be
useful.

Peter

[1] https://patchwork.ozlabs.org/project/uboot/patch/a0ff0888-4c66-47d2-b79=
d-c27a2421c24e@tu-dortmund.de/

> Signed-off-by: Andr=C3=A9 Althaus <andre.althaus@tu-dortmund.de>
>
> ---
> I tested it on a Raspberry Pi 4B. When booting U-Boot from an SD card,
> the network is stable, booting with the same files over the network
> and it is unstable. After appling the patch the network is also
> stable after netbooting.
> ---
>   drivers/net/bcmgenet.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/bcmgenet.c b/drivers/net/bcmgenet.c
> index a0264dc386d..f2253b25bc1 100644
> --- a/drivers/net/bcmgenet.c
> +++ b/drivers/net/bcmgenet.c
> @@ -522,6 +522,10 @@ static int bcmgenet_phy_init(struct
> bcmgenet_eth_priv *priv, void *dev)
>         if (!phydev)
>                 return -ENODEV;
>
> +       ret =3D phy_reset(phydev);
> +       if (ret)
> +               return ret;
> +
>         phydev->supported &=3D PHY_GBIT_FEATURES;
>         if (priv->speed) {
>                 ret =3D phy_set_supported(priv->phydev, priv->speed);
> --
> 2.55.0
>
