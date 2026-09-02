Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2A9C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90FF180B0F;
	Wed,  2 Sep 2026 13:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GD0R-Q8rWpsU; Wed,  2 Sep 2026 13:37:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356238;
	bh=g/ROv4/e93wM8wS+v4eIfKfD98646KRViiGRsQlU40k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WWK0qug7Tl28LXuwgStRgvGHvIoOU26PNQdo7WqAbDbdEGDYCdpnp9DwaLPz8geOf
	 PLJ3I9H3cO+ZXnyXD+N70PvsnB8haKsoWUlUvyYzw+Jj6U2SywftPKtSYxooGJ9Xn/
	 5NfAVBcWbHr7oAclkk5y0Y8Zy73Q4DeThQvZ2N9LNguzFkCCP6UEivva3uWrobc8Je
	 F/8CVjn1Rucq1HdNv65qSEPCzGjujvz3oc/ljUaCIU0k7DLYnDdYCT5mgeM4IXfv7O
	 rx+mQzludZA3mHsfTHauK4CF7/UVBdjUDhjObfPYFrRsb7/CmEKtbafYxEm5r1FHQ/
	 sw1yRm8I+XqJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F21780996;
	Wed,  2 Sep 2026 13:37:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3178B2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17C2C4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:37:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id he2kFB0ybOtA for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:37:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kC2gJGpv
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1754A4006F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:37:16 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5aec201b582so1362613e87.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 06:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356235; cv=none;
 d=google.com; s=arc-20260327;
 b=l668Ltb+i08uiKHiL4G3oICz8sCd9Yif8j+hsMxKtzkVaNPr1i37w65kn8T8FhRLvw
 wVo2kp5o+XYdhetTbT1e8TGzl0oX2iQJTSHcQtJG8R+6TnvwxFJ36kWqJjn2zNud60tO
 krWnHJrsI0Iwt53lvfIbpKCe3dONnSQR9KbnX1Gz7w6exnEnul6XhehwrbTlcuY7yxvw
 5gYAXD9t1EeIco1dpeRyOyNSLs/eRL6qrfK4faRP3ABVhRyVYO3ZUeMk3EzCzCc7msor
 SgigqCCI1tX+Mxih8M21IfbYUeM7qM2L8yLZW45ibVc+YgAdXRRD1u0+NrGlfAvrdfTF
 uVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g/ROv4/e93wM8wS+v4eIfKfD98646KRViiGRsQlU40k=;
 fh=zNeyBnjrAysbtUfZgFOB4wi+2OEqssRe0T1kOhGUqqQ=;
 b=LFeRTx7q48UqkkM/97yRPV4BvE5q8OlGvaaVfz+22eVXnW7zjh9xkYYBifGiCaleIU
 aqmZX5khmygXQKTQEcussl49RHllJM0r75VwXaBOWAHdXOXW4fW2Nj9HjxNX2m/CvJ6U
 6QUpD8nbOJtAzcHCOi1XU2mdvF2UvfzeAtbYmu4GQPZ6Q7n4yI5wcirkxWhtjOlvmBF3
 stnojH33XHxydAtLmBWbSJV/3vm32/sow2xC+ZVPEWWSawMtrkliFdimU5V2vjKIAkLc
 0CF7S/aY7YI8bo/UAbgdd4Xec55fhodz1+37/OFP6HCYRFWrQWdkjDAUiqaly1RKNzwJ
 6oHA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788356235; x=1788961035;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g/ROv4/e93wM8wS+v4eIfKfD98646KRViiGRsQlU40k=;
 b=kC2gJGpvO4l1cp9NM/geK3+aqLyXXY1eyEjiBjFcWW10Yu3lYEDjFyDboP1BJ/hqBP
 XmoXnBltlujYxKwMxY0nial/lQv5z8Ws4aS2lD956n3Jk88ZHEAlv50j/S9M8JAMOq74
 E7w5+kee2Qz1ZrhMcpdNwddxgdRFJS1TxzGMXwKxZMbtG0uAXGa+bN4vl6tEjAz8XDKP
 v8YTSHDgPJhYT6ZqxKHsG/IX6oSmuO7Cbuy2GQyDHB3+VOGcw9r9i7mveRcr+rlGtO+f
 Wc/eHYDFLsITLeXmSFeIB5dk7l7yHNb1/krIXoqXdtf1xXdsAmDqrq4ovxhtYX1qdIWd
 HfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356235; x=1788961035;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/ROv4/e93wM8wS+v4eIfKfD98646KRViiGRsQlU40k=;
 b=P7UKB0Yju930nG681ncftgwifqE/m13t8rLnqmFfGSem2J/DK96E3LIsEkOg0W2HTS
 7qg4EPOjoHSaiRoyywcv3HSHeb0WC4O1YBXWwBBByrl7u+wf1/PF6s6T8eAkKWrUHEq7
 yG5B4DvZhqhvgx4vMZU8SlXfs08l3/ZvoPhU4ufm8JbDat6Mo3lj75o3iv0HAKY6lkp6
 KQCjzKHpREZWrVQg8K/ZamQwo7Qxttdja+h7YbeZSuyQk6awJemkpHx4SrSh9+ByTSGQ
 pHXjsWIIP76Jlbb4+H0CcAPB//syfn+oK7nyfRBkXcqt6m3SVQ2cnyt1z55ZiptT0dWY
 TElg==
X-Gm-Message-State: AFuF++l4z+kYe4yNtCyzFORMkbS0/w7orTn66hyFLfRE48VN68AvI9ii
 xmfK4/NqNtzvdHZzM11dsgAI85MVf8HDDseR5z42UYvbdq2AFZ0mlheYbRbDz1N0P56IVnHEhhI
 6C8KxSwyeVJoccoqkzbdNVO2oPVMQYi0Xj66S
X-Gm-Gg: AYBFou0S+2HG9G38xp9vFseQ2G7uT3AQyBEzbht+HOEOEcCynTeVS5asZLIAjf9vVNB
 4bLlLkMTXV/mOJuhSXMpfd8N9kAmrk19Iwks+FoPeaePggZjgvzQqNPkRINGkJRYzvvzUENseML
 W+GkbjyeqhnVynYovfNgncvX3Od62eRWJZhMXZrNzKeo8TcpXGP8rYPRL6f2Rd7syRkCOu8N4Fb
 JrSIb8YYO3o05W4N6n6RWp/0ZwILrQuQCmYbS/IOt7Pns6oTqlvQN6hvqicJlp7ZDNXNlqbgRiO
 xSkwoMgeUBy0OSG9lTXsn7elexqlsjQ8xYg3hAbcSBPK0nHeFEPPKBF5sNrdGp6UofVTdAPUnpg
 nYXBMQbetjeIry6XdeLSjwGbf5gvR4MTj
X-Received: by 2002:a05:6512:3b22:b0:5ae:b2b0:4c0e with SMTP id
 2adb3069b0e04-5b609196cd7mr1758100e87.1.1788356234344; Wed, 02 Sep 2026
 06:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <PA1PR10MB9387AE5B8B61E648D45512C7B7B72@PA1PR10MB9387.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5AXvzB9qEwD7Y5NjbEOwpJ36GRxz26Uwvriqt=pEuf_cg@mail.gmail.com>
In-Reply-To: <CAOMZO5AXvzB9qEwD7Y5NjbEOwpJ36GRxz26Uwvriqt=pEuf_cg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 2 Sep 2026 10:37:01 -0300
X-Gm-Features: AcwNN1UMBTkyRGVD8_k9PZBjjea-T5UCEV_WuCCAzqZAzft3V7kWyYlGQIQks64
Message-ID: <CAOMZO5CEzoxfY-YvP1=Cg_euAQDqjutcswousn19H-H9+cTe5g@mail.gmail.com>
Subject: Re: Bug 32bit truncation in mmc_get_env_addr()
To: Torsten Rupp <torsten.rupp@8tronix.de>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
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

On Wed, Sep 2, 2026 at 10:36=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Torsten,
>
> On Wed, Sep 2, 2026 at 10:10=E2=80=AFAM Torsten Rupp <torsten.rupp@8troni=
x.de> wrote:
> >
> > Dear U-boot developers,
> >
> > I found a bug in mmc_get_env_addr(). The internal calculated offset is =
OK, because that is a 64bit value. But the returned env_addr value is only =
32bit, thus it may be truncated. If the offset for the environment memory i=
s beyond 4GB as in my case (Raspberry compute module 4 with 8GB flash and t=
he environment is located in a small partition at the end) the value is tru=
ncated and the environment data is read and written from/to some other loca=
tion which very likely will override some essential data there (in my case =
part of the root file system).
> >
> > To fix this the signature of mmc_get_env_addr() have to be:
> >
> > int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr);
> >
> > and in all usages of this function the type of the return value have to=
 be change to 64bit, too.
>
> Please submit a patch:
> https://docs.u-boot.org/en/v2024.07/develop/sending_patches.html

Actually, the latest documentation is this one:
https://docs.u-boot.org/en/v2026.07/develop/sending_patches.html
