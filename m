Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A83CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 18:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAD9B80F13;
	Tue, 29 Sep 2026 18:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ViPMbTWbn_tT; Tue, 29 Sep 2026 18:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0634080F01
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790705762;
	b=Fa4VNvPadl7jvKeeorTMxi/+b1UQhmzF5ZuCKRmr9T0J7ydLI8Ey5O4HemtWGORSZf3o
	 9nny9yQevA28lkuyDa8oafc4WOx8mN5QpuaQonSUErvUPkfuQP8/fmcFjbPx25gUtIrtp
	 szmorzzQpm7JnHevAwyUbE73scBM0PIwa08o28BIT06XY0F3/U4YSH/eE7pcaMhUSxPCL
	 RD/mUfe/r/r7Gfw0Arsj9N3BHmoO8W6RrzfD/Rksz344bj3LTaJK9KcDkm/VC5qlwS+kX
	 YvoAD0X4j+e0OUAA1f0zxmlRojd738iO4Fg3O0eJnV9HH489iqokr9zpMojNXYW3gKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790705762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0vp7hDNXDZ92qhrs21DJ4YDah4Ba4QP9A+jskmTiySk=;
	b=BQb5Ysu9q0V1/41xj6X1Q76ox7d4dL167D5h4T2iOnDKZzHIT1lpT1IzNs8iBq+89b/g
	 KtPEih/zgYJhs1lQKWPtiR+qJEyd8mQ5F0S1jDLf7Me8/gvLecvou51LecGD1n2s/c8JB
	 znn21jDYsWHjof1tzo77lZItSdRSkGyPdn60QGp/XFGitcwo0lbqEKaI/rrhW95RxvBzD
	 mhXLAwJaEq46PC9OmTH1bTyP8JPINVBCUWgrpPQULmeLi0Vv1vKrB2S+XSfofqPCjPtDt
	 jJp64P/OdXfnWbtcNOUBXY1TiOXk5OVTZvuO5tirL39Zf1VTOkNURjJrvS9SErP5phw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790705762;
	bh=0vp7hDNXDZ92qhrs21DJ4YDah4Ba4QP9A+jskmTiySk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lY0CWErkWzc4/C21dvY8uL04Qkz/Y2kRk4dC+Q29XW4Wj1pBoJazZ0UGb+BE5Vljf
	 S+gncSBbgxp1HSTVG6BRAa75nrwqp0SUPzrpH10c6znNKQV+WOFGWANtJshtiVwk5Z
	 P8+V+mGqnaoOO2BUv8i9xq53uFU+HMKKq7rr691Qh393xf2thbpfQXbPtf2JSrvvt/
	 sna+sptfMAsEFtWY28n3hjUxjTWibIJ2idNODwLf8Cg6zzguFmNlBYmHy/sSkilKW8
	 4mlACkcTgh05atKzQp4NuKKVwTo0ZRTbuRZB1izu4TAaNnfLwFLTm7D6tJDIDRLkZQ
	 odqkQT1eZqMsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0634080F01;
	Tue, 29 Sep 2026 18:16:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 62CE6282
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54767400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nOh7_ZW8LKDv for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 62CCE400CC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790705759;
 b=QN5LPHAKYk9LEIAMPbMFVRYd52Z8aP0HP6997ydG40SMPAFN/65bKM/oyJPWfFTwajV8
 BUM9gxSo/G7CQLSXGUzP2Po4jbO2+DzTn5434F6bs6Vdpi7USz8vg+Y0Qxa7ES6qZrVCg
 QSrzwIcN+zvh5ltFSLB+PZa7q/yW2GM8tx678hBrZkEWdR3wj8tfuwHrT1U08avbC9tWI
 HmI/llP67p15PmL6GhgF17R44ChXiJo6HPKF4Wln2tf7RxQJmP0R7+LNhx8/Q8ENtSleX
 vEAzTEXScudMk9mQZMeT1LMmo0YZUdIXAelU7zlqtr9GLhfd+rYJGQ74hBjoOQDM6Hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705759;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=0vp7hDNXDZ92qhrs21DJ4YDah4Ba4QP9A+jskmTiySk=;
 b=E9UZEflo0i0Qn5143CYaJlB4M+ON/CbyRrALkdWtQOyN6i/MnuX/gP6gbOnU0kUSGzK9
 u9iudGNn11jM1dKVsdNiT/fr8xgS/NDIJx6IAKe9U7RHFbp8CWXslMySPX+YYdD0T4+yd
 Gv0fVYJzv8XroBHD1xjX//vs0FO2WpC7iNPGyCDN3DTdeAW0rGzYVg7df+SUtyfXlPg8U
 dJ4OXMR2NwxZhY3DgORAkOxNb9OiJY0ad4X8y3w/NCwxlmd9SMtw60o4jpe4Yl2InlGo1
 ZiJvwX/EQP56q++DmUkdsTdY/dX6SJ9bgLdQGU0gZW/8yj0V+b3zA/0BcYNMqEZL1HQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=sifive.com; 
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=XVsMWWk9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com
 header.a=rsa-sha256 header.s=google header.b=XVsMWWk9
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62CCE400CC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:15:56 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b8e6ec4e1dso3424285e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790705755; cv=none;
 d=google.com; s=arc-20260327;
 b=r3F1Ct4vKRmeXO+1hRAKys7xZs+ARYjHrd2xuvhpmcrX/dFkZ8R3P1y2Ez27NmTjjn
 JwkQBkHN+A3KqVW6YA4Al/DVry2si/av4llxeLBHadp8Rdktg/TSwmWkynmOHV+aKAk7
 TKMoqb+O+Lfk5jXe1Q9/QlR9Hi+o16HqLR8bdOPrDyPdgOBmxZuknTJupBf5IlITgfrp
 ovpT8WH4XHNfCQfVVdXMX6GpdSc5pxQfRCMMI8hDUxzLyzJa8UsONYEISPU81806m12D
 xtC/7UAN8UyMHx75IDUdhHPuJVPOesk6PuS4YtsBJnZs2bj+vLn836Scu/dT7GePTeVB
 MzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0vp7hDNXDZ92qhrs21DJ4YDah4Ba4QP9A+jskmTiySk=;
 fh=jvKmhbnzNaNFtBchQzN7LQLdUCQaeb+n1Pqdn3xKZlY=;
 b=QzJVyl//2hQC14P+uW5G7zCgCf609zk1NJCwYWUH/Bso851J3OcGKosq8P/C3iGo+Y
 9pyBjY98YN64qxShgcXy8Kzwf9Inica2bC6Fp+0rDIJqkpQWZzFgNySLvgaBUHUrl6ek
 DLeTDnUV4h4qaX641OBCSKAeH7z5KRit4HbXV+ZLyJfvpF/n7/hWYsQ/wZ/ykR308BV9
 ISmTWK+Rlc2eDSYnrr0JqcnkxqC1FjLlrKQkPLryaOotniSKSIp38hsJUP/Ljwrw9Fyi
 73ULqx36RVDX0fySKaWRr4H+a9xO19/8+xstm0nwaWqfIfX73BT040GNUOfsku3fwBwI
 GJ0g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790705755; x=1791310555;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0vp7hDNXDZ92qhrs21DJ4YDah4Ba4QP9A+jskmTiySk=;
 b=XVsMWWk95qH4HkxqvRu0Yd8BQEN0lkTI71EiMpeoWGL6OmZS19Anqhk7cieJseM/v3
 RlUcIq9cUWXXYwPfTIQZTyUNSdn7wIRCFuGJsHd2q7F91gdf57Lu0ZmtoWjD9D1hGT/w
 VfiLhU71Ba/g+eENkBSWJWPAQwcvbdMOYPlHOyO+ikeEE++LgLZjqICiUo5bHCEQ+v2Q
 ukzkBjCBbB3Cvtg8kvWMlq05coeEkiCpe18Fsvc0VbuWHc0eyaGME/irgXcGiReXdHYI
 UoKupPS0FxKrUJgTp+hOLYzAH1ACGMCfWUVMwGdK0yAhsS87Zfmf0TBUTRGKBX68wqb6
 C3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705755; x=1791310555;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0vp7hDNXDZ92qhrs21DJ4YDah4Ba4QP9A+jskmTiySk=;
 b=jbBPUR0uHyO4YSnFSU3fE9V5ygAsF71G0NjdVds5WL6d9g3YUvhld6lGAFgEInj5sd
 0Q2HF9ZncqaxnIPiyQ4M5vB7Q5Zh4e7nU/iaDcFiqevAXWtCBnxSs0RzMz5omcQ6gMCO
 9K3v+9mvbrHWcwn5zVjtIEA37DeN/beW99VHQFinQpT9pmDlpw3CiJH/nZUQrKig3bk6
 LnwLif5ufreAJQmS8uPxf+my47rTyVmyPKJ7VIRkmgPmmXjV0PZajepK1jLMQje8jC2F
 eu23zZxcxgSalDDvT0RdGp9ypYaaCdLIvUWxEwqGwDty5DReJ8uzY7J3bC4NIEdxGk6S
 LW9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9agNrR28n84ikIvwaGb/wNyDRcJqrF/JrBl3eUJkYlI8olCaaGLmaj1XoC6iiVp6y+fZZ2iw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI9MtISw1xwqMvF+QWo6xjGcbvxuM7jCf3HCMPVQxvUgVd/67J5
 XVb15EdNbGZe3cIzBZmvgmwrNZfVk8aBY7tPoZtZAKhfoDJ2/XmsGcPyYrRftjXY7cia7cJ/oTi
 WVrTUlDmr/a/elAWhWZ0LxTsDVhIgfPxWy6tWo6eXyV8Ba7CXXjFm/GA=
X-Gm-Gg: AYBFou3tDEDij8p/qJAOZaUYwCTbTJ2Z3NAKHHfOVBN9YaJ/iekEm0iEL5pW9ICTYEn
 5asIq+IKGu/UP2l8pkAp9wtsuPyvdK9AqwRN6vxAj/TkiPwAmHqUfidO3ImtsYVnVnHLL/o8nC0
 8WWdUdnEc8wl/SQ+79nHW+A9SvzLp6Yd8VlwLDIpA1ufJatRyB5sVHKZwJTP6V9tdzNQCnVzjZT
 G8vKdPFsNhNOfUso+BgvOrPPBq1oR4+JehWacM3MtSsb0VScp5flyPW74IP7tyXFEZAjVACKCUk
 mgwQGFMBpjzG4I26ZA4rYsR765ahk5prW3MfAu1cFPtOaBfpWnNJc+aPaT4=
X-Received: by 2002:a05:6512:490:b0:5b8:f2bf:6ba2 with SMTP id
 2adb3069b0e04-5ba3bcbf57dmr77309e87.32.1790705754460; Tue, 29 Sep 2026
 11:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260924063843.8934-1-e@freeshell.de>
In-Reply-To: <20260924063843.8934-1-e@freeshell.de>
From: Leo Liang <leo.liang@sifive.com>
Date: Wed, 30 Sep 2026 02:15:41 +0800
X-Gm-Features: AclHuK-oHKLT46O7f2e4XUW-adCSUDkZCHUia2Hk5jzd85DZ5hDsKJ_ZFh5K42s
Message-ID: <CAC7DN2ATZ8McY+=b0jVCd1CLc4jWqja7GXattUcLMPo+cAeO+w@mail.gmail.com>
Subject: Re: [PATCH] doc: board: starfive: update jh7110 build output
 description
To: E Shattow <e@freeshell.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi E,

On Thu, Sep 24, 2026 at 2:39=E2=80=AFPM E Shattow <e@freeshell.de> wrote:
>
> Correct simple mistake of '-C' change directory combined with 'O=3D', as
> Change directory has precedence so 'O=3D' path needs a parent directory r=
ef
> ---
>  doc/board/starfive/jh7110_common.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks for the patch.
Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
