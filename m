Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B77BC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 848B660B7C;
	Thu,  3 Sep 2026 14:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-JU-n35lO4m; Thu,  3 Sep 2026 14:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4314960B72
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445893;
	b=O54rvr3wJS7kFelGHHEmjWQcMbXx+fi6Szh6Q8rRuxPf61IBj5GgbPEOCfnNmrt8mvL8
	 0qWpYJr3HmJYT7ccCxL4keVe85VBVZWNNPWK+xQjIYEJm/W/+2sBE6jWeQmnQXFEWa9gu
	 MM4QyCnQ5pTPoE76kJJAE+7y/PDZNSANBzhT2O0kj6lkigIyt1vRcrzzr+gqhqM5hReQF
	 UNXxB180j+WTKiQrWaVoWoIosEheXFmV7MecG5Qln216yu2JVsWJKR64OXVLh62V5aw7z
	 1jXbqvZ3JFlTiQyZ6CpEhVVNDkfwhe/uBu5pLvNs8Y9QAimZ80EJCkSI/9NzE3u+SJw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788445893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uSTAJD9ninz4TSQaCVUVq/HQ/cJLU6VVdBlgrX3Ks/k=;
	b=QXGLY4UB6V0FZYZHr8v5n6S/oqKhIJ8P7JeLQWL5qa8b8J5nPPJDuUA1nVWNrGrE2Q3I
	 cYDJl8YXOnMlewi5A/BVz5b2pg5/m1zU31/ETNaodA9fvwlFJsvWjLxQedfY8UGsHcE2D
	 QjWJIhZkzTgfMyya/MlRYQTTLkbL/zblwD7wq7J2QFtZ31amnoz/3ookxs+kPf1Q6hOrq
	 Dz95auI2xoS5R49wW5vZR91K+Jx4HajHsAzzdVHPFyfvIT6u/rqDaE/lPoUtchAZFudIP
	 2XlIfEmw9j8bd0wY7qea5pp27BjZqBMwlVW4G9dqvQQCZg66+m4ylq/VJZrYzmZf42w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788445893;
	bh=uSTAJD9ninz4TSQaCVUVq/HQ/cJLU6VVdBlgrX3Ks/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b3uOa1miPWHEj8UljYL2S/vgY40gFauEElrJ/RB+Yz6VF8k3KAnlBfWJM+zjUGNHW
	 yCWbuDDexdLJju03SKXwf2m01gQsPys2JSXZ5MyoItZIljEBSouoHB6iLuOHbj7mT1
	 SnZqdvLVDfbkbN4ChWppFCRDzPtBFqs7K7qP8XVwpaBIKuRaayuNgVHOmGIjtIHUoW
	 shdjEPp5MoH0Fc+MIcJT+nM2RiCFItpYhfE+Wn/ye2TpWasbOez5wuQ/S6uBZWKeTc
	 NUyoXVfkfjOU7FJPUIvdQkjqNiAP0Ysia1KrIZx0jGJuoEJhSZvm+EtznaIFDTQ8/a
	 9qSYHSWz6+1FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4314960B72;
	Thu,  3 Sep 2026 14:31:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 631E4D5C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49CB240AE5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ASBStpRZGwCi for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D700940ADF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a29"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445886;
 b=dZrJG7jZyo8BuWda2wpJaVr3rAadrSonPsyVREAci6P41wDOWDsmsH3Nllmhui4cVG1W
 YnMJStOkxsAG2V9AKpauLm43kRpbeoeZJJ68M5m7On6M/0ONdxJ1C+MNQFfdZjYB5hpiN
 MTm561RlVXmlYdAY/QkeoE4tUSgpt6bhTm7kqUmrGsQ2+wgvfEd3rv4J60nofn93DCbHe
 BwIa1VzNdu2oPN27/K7UujWk4G2zAGhn+NB0CRYdSHjZtQ94SUKnRno2WFZKfJ1z+I61q
 7QqgixH6j5HRr6/sXklHAVJSSgLx0ItHfoLmfmTeRA40xMvP4ec+Nfi1XRjht55uLkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788445886;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=uSTAJD9ninz4TSQaCVUVq/HQ/cJLU6VVdBlgrX3Ks/k=;
 b=Jj3C5fs++BZIhfoq11LsVceVIOjKNTJL7KM6A428VsfkKqFFKk5erch/Ie9jtynIyQuY
 uCWV1GNnIEgVfr+IA9E91VpvA8HjDGgApWf3rgbS4kLKOYVUzDoto4fzvukXFG2QSwzMO
 vpxyd73YJdJ301fKQ2yIrE4E+nd6wYHOn17tY+zs0nMvRDIn03GVoqK59QtHvkcvd9HNn
 31C9pWPEUhp/B1WgpVVQmMfnDVNA9LG+1WvwKz6sP3DNBWmGRxZwyQGS0adO1Xtbt7V6R
 Y0A5hTPJ0q14dvQY9CtrZ+dnisV6DMn1S9/MmsJh6q7XaFWglQNsGxdfg9Il6l3Zt6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EO2kfu15; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::a29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a29; helo=mail-vk1-xa29.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EO2kfu15
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D700940ADF
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:31:25 +0000 (UTC)
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5c675de8e1dso1001633e0c.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788445884; cv=none;
 d=google.com; s=arc-20260327;
 b=iuEOib5v7Dcp9rff7vn90NX56ncc0t8X6HJ1vYE7qWkA0PFij5M4kDzA9XrNamw2kG
 Gyxux8gf3Aq5/dKxNNhJ3Wkih6qhmN99WURw50mUJ7mFHDAxcSxRh1kbSw2E6lLZNXqP
 9tyT0HMrGBH9vLOrc0HOt42ZoABPQ1mjmE4xhJZgnivg8g2600qqMP+Md7z+6vHYorLH
 svqEzdODXbMApDia7v/e7TkvUoZVpyk+o16Oqyzl8GUyJDyOkbxk7Mzz4MTM8HS2j+ks
 sKyrDYkNXlGJeo5eiLchz5d1EI/cjUXSHv2LeksfG7NPp/f/xNTHIEAE7ODUowFHvljb
 6y0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uSTAJD9ninz4TSQaCVUVq/HQ/cJLU6VVdBlgrX3Ks/k=;
 fh=Awbblk7Wf/6pmn4EA8n/hdE6XsEaLDwFivmGXzDiVqU=;
 b=AVeIJGSwcPVMVrc2pNuGaeaqhtEmBBXa6l2SK0O8i+s9M0Rd9bKLpyOQ4cXXfQMMXw
 mi8RetC59IovbnXWN67Twe1nAjSK9MU/2SMeujahn0d03Q1DhU6pS+hhctK6VfphuxYo
 zMoHg1uXlng0t0wKRkFY/oJFWRXkN4L/S4caFSw05oq67AIjWQUNrPQ2o8XhIPEuG+T8
 vhszAOg218FZQ/AoV6q4J8jL4+XcBgUOjMQYDutvQFfGjvyLLmGYOD8gxu2/2ZZkXHQR
 riYBdfIJ9z/WPXprZ71qa3ezFbhwaxvg5Lt1/oO+hVK38C7k3jEwADeq/TD4eRlSBwUw
 7psw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788445884; x=1789050684;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uSTAJD9ninz4TSQaCVUVq/HQ/cJLU6VVdBlgrX3Ks/k=;
 b=EO2kfu15EIx2pyBtBOVaLLHZdGh32x9vrMAP9rDzre2AYRoYNYzVScSoB+CsJ73q03
 fnB6h9K3441ZfV4z8Br4IhVw86QlwYtqCAGhwLq5bckKaZ+ktpr2mwdEs1aGiNenxgrh
 T3lJ4edokenML0S5XUUPq1qxK0K4jUb4OkM2dJHCOCAvy9Vk1n0JXykMIJPnrg/SrxiY
 LqBEqlHlDuWQDRwYxG2MeWHX4rChfxKifOqLZ9T2uIim2S32wmW9GeoxZ/016NV+8MgH
 Svese0PfDrxI6WBqX1TJEYlIb8hrjfnPKX49BeWKQFcUGQs/WSqHF6T6KNWr4sxkIEIc
 RE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445884; x=1789050684;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uSTAJD9ninz4TSQaCVUVq/HQ/cJLU6VVdBlgrX3Ks/k=;
 b=PDFa3hf3xuZQFS/aQwGD20b0od8eI1vd5AE7mlZj8r9ZKOsOClfnaeeu9eiXrxJD/X
 3Bpf9jTqJ3+kCWoXtP8J7AGyM33o5fXCRKfasV/MjVbMexrcQhvQPdCIpPdHt78VaLVS
 q9TVPIDVyB/O82rUYi8WJkBrr0fpPKeJZB1KcSSzG3Nf9f4VUzDElReJcGivgNoJSnU4
 7/wKhFqT2LGVMJp7ghGex6Duqwq+hcE6SGDTOprfetSiidzaXpOfnIIriVJPVehfd1ux
 l3ALbH7SUhpuc0Rvv4wgGpX3CzjiyYast1OQF+uyKRwxLLLl0nJ44V6iCXgIQF4+cYo7
 cRoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBww6SAoKXOlGBB5QDt29ocWgxe4fout7NZiGPjysv9EaZqoous5WmHuS4tGPMUw9Jcp+N//+NA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mFkAxbchoW66ixQ7SbEXQocuiRN9Rd4FhI42/4/g8QGmTj8ny1
 5md2kHXzhpvQhvEa49FmHXSVgtrhuBYztRJ/rXqXDgqgi0Wz/mzBAYpI4vlBvgJVgwUS3sGWYv6
 j6J/THakEFSUBP1WdnHzk0Y+C0qynh18=
X-Gm-Gg: AYBFou2Ka3YGS+ohPjvB0pq1lOerutPehggf/sdkpJeijqYT7n/2DUiBYB5bphjjbQu
 ig8ar1NWdNTBMPYMzDn+jfQYoTlLyFcpVY1veUDlr/1z9L4oWYKg22P5DP81nO1gkF6aFHKoALK
 SUrSy5JrqS5zPSXIrejPBW+RpXetVG/u/aMnP8BA3yFXf+fSWvmtVuTCRAbpx4kVeEvgZdP9UfI
 BpEt4Ly/Xg7L2YX9KZ1m5YSe1aZLZy0TF45xTltFY8CrNZx++Yyvf4kN9+e+smhFRpAD4SmiACR
 fSbnHaTZmMxIJXaVxNx2vPxT/z1hPtdg0PeGGvtsyGvbSWk=
X-Received: by 2002:a05:6122:507:b0:5c7:c2dc:f1ff with SMTP id
 71dfb90a1353d-5c7d2705702mr4974199e0c.1.1788445879512; Thu, 03 Sep 2026
 07:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-3-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:31:06 -0400
X-Gm-Features: AcwNN1WvzKi82UAnK1otftVfzoAkz6pA7O3mo63bgcTv84TrLCbU224qWYfX_JU
Message-ID: <CAMDkj5y0DzA2XpvAFzsUKF8JTQbkebxPZZMr_k2B-_Yg3oF3hw@mail.gmail.com>
Subject: Re: [PATCH v9 02/15] mbedtls: enable support of ecc
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Prepares the support of ecdsa signature check
> using MbedTLS. It introduces the option ECDSA_MBEDTLS
> to enable (or not) the support of ecdsa in MbedTLS.
>
> So now, ecdsa is no longer supported by default in the lib TLS.
> To get it, the option ECDSA_MBEDTLS must be enabled.
>
> The option ECDSA_MBEDTLS only enables the ecdsa support
> in MbedTLS, it doesn't provide any API to use it for
> signature check. It will be done in another commit
> by adding the option ECDSA_VERIFY_MBEDTLS.
>
> Two internal options are also added BIGNUM_MBEDTLS
> and ECC_MBEDTLS. Those options are used to share code
> between different option and avoid duplication.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - move ecdsa to MBEDTLS_LIB_X509
> - enhance depencendies
> v3:
> - do not use _MBEDTLS in mbedtls_def_config.h
> v4:
> - do not select ECDSA on some configs
> - remove duplicated MBEDTLS_ECP_DP_SECP256K1_ENABLED
> - change dependencies for ECDSA configs
> v5:
> - MBEDTLS_LIB_TLS depends en ECDSA_MBEDTLS
> - update some configs according to previous change
> - build of ecdsa is conditionned by ECDSA_MBEDTLS
> v6:
> - fix dependencies for ecdsa and ecc on mbedtls
> - ecdsa is no longer mandatory for tls
> v7:
> - no change
> v8:
> - enhance the commit message
> - use /* */ instead of //
> v9:
> - no change
>
>  configs/sandbox_defconfig        |  1 +
>  lib/ecdsa/Kconfig                |  1 +
>  lib/mbedtls/Kconfig              | 17 +++++++++++++
>  lib/mbedtls/Makefile             | 17 +++++++------
>  lib/mbedtls/mbedtls_def_config.h | 41 +++++++++++++++++++++-----------
>  5 files changed, 56 insertions(+), 21 deletions(-)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 5c97418783f..b9991d269d9 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -389,6 +389,7 @@ CONFIG_PMBUS=3Dy
>  CONFIG_CMD_DHRYSTONE=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
>  CONFIG_HKDF_MBEDTLS=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
>  CONFIG_ECDSA=3Dy
>  CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_RSASSA_PSS=3Dy
> diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
> index ca13b6bfa1f..dac8bcf23dd 100644
> --- a/lib/ecdsa/Kconfig
> +++ b/lib/ecdsa/Kconfig
> @@ -1,6 +1,7 @@
>  config ECDSA
>         bool "Enable ECDSA support"
>         depends on DM
> +       select ASN1_DECODER
>         help
>           This enables the ECDSA (elliptic curve signature) algorithm for=
 FIT
>           image verification in U-Boot. The ECDSA algorithm is implemente=
d
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 789721ee6cd..e019f17d6bd 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -247,6 +247,12 @@ config MBEDTLS_LIB_X509
>
>  if MBEDTLS_LIB_X509
>
> +config BIGNUM_MBEDTLS
> +       bool
> +
> +config ECC_MBEDTLS
> +       bool
> +
>  config ASN1_DECODER_MBEDTLS
>         bool "ASN1 decoder with MbedTLS certificate library"
>         depends on MBEDTLS_LIB_X509 && ASN1_DECODER
> @@ -264,6 +270,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
>         bool "RSA public key parser with MbedTLS certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         select ASN1_DECODER_MBEDTLS
> +       select BIGNUM_MBEDTLS
>         help
>           This option chooses MbedTLS certificate library for RSA public =
key
>           parser.
> @@ -292,6 +299,15 @@ config MSCODE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for MS authenti=
code
>           parser.
>
> +config ECDSA_MBEDTLS
> +       bool "Enable ECDSA support with MbedTLS certificate library"
> +       depends on MBEDTLS_LIB_X509 && ASN1_DECODER_MBEDTLS
> +       select BIGNUM_MBEDTLS
> +       select ECC_MBEDTLS
> +       help
> +         This option enables support of ECDSA with the MbedTLS certifica=
te
> +         library.
> +
>  endif # MBEDTLS_LIB_X509
>
>  config MBEDTLS_LIB_TLS
> @@ -301,6 +317,7 @@ config MBEDTLS_LIB_TLS
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         depends on ASN1_DECODER_MBEDTLS
>         depends on MBEDTLS_LIB
> +       select ECC_MBEDTLS
>         help
>           Enable MbedTLS TLS library. Required for HTTPs support
>           in wget
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index c5b445bd85c..0c86c90d15a 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -39,13 +39,21 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) +=
=3D \
>  # MbedTLS X509 library
>  obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) +=3D mbedtls_lib_x509.o
>  mbedtls_lib_x509-y :=3D $(MBEDTLS_LIB_DIR)/x509.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECC_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/ecdsa.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/bignum.o \
> +       $(MBEDTLS_LIB_DIR)/bignum_core.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) +=3D \
>         $(MBEDTLS_LIB_DIR)/asn1parse.o \
>         $(MBEDTLS_LIB_DIR)/asn1write.o \
>         $(MBEDTLS_LIB_DIR)/oid.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) +=3D \
> -       $(MBEDTLS_LIB_DIR)/bignum.o \
> -       $(MBEDTLS_LIB_DIR)/bignum_core.o \
>         $(MBEDTLS_LIB_DIR)/rsa.o \
>         $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) +=3D \
> @@ -64,7 +72,6 @@ mbedtls_lib_tls-y :=3D \
>         $(MBEDTLS_LIB_DIR)/mps_reader.o \
>         $(MBEDTLS_LIB_DIR)/mps_trace.o \
>         $(MBEDTLS_LIB_DIR)/net_sockets.o \
> -       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
>         $(MBEDTLS_LIB_DIR)/ssl_cache.o \
>         $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
>         $(MBEDTLS_LIB_DIR)/ssl_client.o \
> @@ -82,8 +89,4 @@ mbedtls_lib_tls-y :=3D \
>         $(MBEDTLS_LIB_DIR)/cipher.o \
>         $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
>         $(MBEDTLS_LIB_DIR)/ecdh.o \
> -       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> -       $(MBEDTLS_LIB_DIR)/ecp.o \
> -       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> -       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
>         $(MBEDTLS_LIB_DIR)/gcm.o \
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_c=
onfig.h
> index dda3f4dd6e4..d55f31acfda 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -62,6 +62,25 @@
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
>
> +#if CONFIG_IS_ENABLED(BIGNUM_MBEDTLS)
> +#define MBEDTLS_BIGNUM_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(ECC_MBEDTLS)
> +#define MBEDTLS_ECP_C
> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED
> +#endif
> +
>  #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
>  #define MBEDTLS_X509_USE_C
>  #define MBEDTLS_X509_CRT_PARSE_C
> @@ -74,7 +93,6 @@
>  #endif
>
>  #if CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
> -#define MBEDTLS_BIGNUM_C
>  #define MBEDTLS_RSA_C
>  #define MBEDTLS_PKCS1_V15
>  #endif
> @@ -89,6 +107,10 @@
>  #define MBEDTLS_ASN1_WRITE_C
>  #endif
>
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
> +#define MBEDTLS_ECDSA_C
> +#endif
> +
>  #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
> @@ -122,7 +144,9 @@
>
>  /* ECDSA */
>  #if CONFIG_IS_ENABLED(ASN1_DECODER)
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>  #define MBEDTLS_ECDSA_C
> +#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
>  #define MBEDTLS_ECP_C
>  #define MBEDTLS_ECDH_C
>  #endif
> @@ -130,24 +154,13 @@
>  #define MBEDTLS_HMAC_DRBG_C
>
>  #define MBEDTLS_CAN_ECDH
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>  #define MBEDTLS_PK_CAN_ECDSA_SIGN
>  #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
>  #define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
>  #define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
>  #endif
> -
> -#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> -#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> -#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> -#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> -#define MBEDTLS_ECP_DP_BP512R1_ENABLED
> +#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
>
>  #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
>
> --
> 2.43.0
>
