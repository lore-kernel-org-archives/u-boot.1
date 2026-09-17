Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492E3C982CC
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 03:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D942607CE;
	Thu, 17 Sep 2026 03:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ITcefof6ZAIP; Thu, 17 Sep 2026 03:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 711086062D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789614124;
	b=N8rlMNQTb42Rs1qSnTtZOwihA0uGcnvIthQvEmCTFEBZYB42jY18DVMUYVxk386vUk1L
	 OuEd1rBvScSui5X596GlmyG8LzvGVFPhbmgqJHfPQqESIN0awb1/pg4kdW7r2208DH9Cw
	 k4TbWC2LFlxejipE8HpCX1GzVokDwxcdDt84qaFHCsXMkoG9FIOiRltVSwNMVHqZfbAcj
	 66udqcjCceDHrxn9dHtcedmXmTJj8DQYb250/JRGDijoSZ/1k5TXiMeHe9fnFCJNs55Pw
	 ActxgjZX2/JE49oaj6sjni1cWSbG4FRDwAmJ1IlsQFku2OtA+XvwKhZf8HFOV27+wDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789614124;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Nk9Kfq+lFXIuUyv6rUnoRt8untRd58WuQSEUSLnKwO8=;
	b=p/A2pbHozDciHCfV9+jUJEZPBiEadgo5ppZ7VWQqQRcD0HAQUCQG5ucQN0ugLP1QGsRW
	 XG6Ur0WSIuLQswNoTScAeQpJS+HF7F/ckyRIjVJjsZuSGw+bwLdmP8yelNc8f+ZUUmLGF
	 rkQk3ffOi+GQ2JCoXeJbtulUO06iKY30LPTxZ7ZQSmr7rbFygjkl9+R6qUdmOii8CHUOI
	 FVsuBeN7KFtBaYbS0sGaiQe05Isqww4g4yqunbv7tgd2sjEQIwn5JV8MFZMiLgjxu2LQR
	 xRuwAF3jHRVMvwkvEzR6S29dLgXO6futdSAXDeLLY8LPFAAp9W5EX75pppo4/rHbzNg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789614124;
	bh=Nk9Kfq+lFXIuUyv6rUnoRt8untRd58WuQSEUSLnKwO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jj6MbM7Wzb48IvviNhJPApmrFHY9D7xQhx1081AM3zU03VB1bJa+wBiMY/GGCNzBP
	 YA1Q3EIXJLsuzXCz/1YyfcUM8/JE8fwb70yEgaz2R0w+rAb4P+7CWgjs3CcBFk3abD
	 Jk3yZTf9PrGcvr5lsi/+0Mkcd/64EdcNrRyPgSlVIAFjZC+6r5zNU5LgRf1ejBsVpx
	 QOfk7U3CJBTWqmu7249NYfJO5cUDaBm2Z8cHA31QWAk2N4Tw+mxhMEG3u7kvBrlpAn
	 NUQxDRvgMewYk12EkZEZC8LLRPjOLo3f6Wv0thArTkI/C2q4g4B7JpwBcu6TW4TLYw
	 TSe0yTLOjOtOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 711086062D;
	Thu, 17 Sep 2026 03:02:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F648422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 03:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5EA6400AE
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 03:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2bMf9TTFn_iT for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 03:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E34864005F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789614121;
 b=chQFQj6AiDiXWzTxKveAsTwBUvcvc0qi+aQWO/Scoe50bArO4KudKkz5l34xniFyZKhw
 1AU7cZNnSvKtl6l4UJfzNZFKcvH49iF30TRJznMAOde9k9umChRjN+q8XvcQxtfHY5EWg
 OIGUwfjCpSf8JdnE0NHnbfsYdwXRMZtsiQyBX/MafS41wwmy+BUiK2Sc7U+kxvKM7epF2
 Swiy0TEKwGtiXdiNs9zR9oOevOCXDC6KMdq8OFROog1P+xVC5u31px3DDW87JMTj/pUzj
 e/80I1dlhJVeshGd/Vukx1olFIBbbta1sr0xW3puwmVxQjRZZN0IQ0Mbb5fB4rxlVYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789614121;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Nk9Kfq+lFXIuUyv6rUnoRt8untRd58WuQSEUSLnKwO8=;
 b=gjwp6C0MHLJRY8zMSkTaSM+8L8TTVADaAiQiIkYzB4MrD4ekyQF7h4o55axXEk9DYd1x
 6WOShJ877vmBg460FoOxBOiai8LPnsGCGDtq/xnk9wgLPbA5ZqZE8QlONfrjDU/WEDVK2
 4hDV8qUQJ/dPccNQjyxoMBg3UPLFZNp/1zOvlhkMXNUoSvbWPV8W/rr85hkhuNZRQyRhy
 dmzgIhACmHO2ytTPrNf368tf0d/OKKP5A6Lwv3VFwV6EeUIEkxmk0SFb9azfdVjpOxN3w
 Fm3hsGRjIuFCjCeIu/y2JmKXNBThpObH7gZQQVUrxKOvO11d9qY8RSENUFq4+UhIcQA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nby+e8w3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nby+e8w3
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E34864005F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 03:02:00 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43da99easo2347197b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 20:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789614119; cv=none;
 d=google.com; s=arc-20260327;
 b=nNU/hT1VVu8bfI0xzuFRzgXNgoEWFfJT+JiQs6L1QNCQJ04u5SeVhV9+Li1EU4qpVe
 c0YGjk3GMq9q7eMSb1ipkSxnISpse9WPTYzvHMHqwpl4rThnvf59dyECvCL0aviuAgm9
 8DMPm43Pr5V4DKqgAV0qtgCzHoBVECoJPlwXfGDTCSOiekVsc248sLeM0oPqlAUqE3Yp
 euzltjKGkBGUSkVSgVBaOOoLt/jdzzdc/eWd84qcYsjaZA+pwa2Vgakj0mxOLHKTFFzD
 4UuY5+NFV3yA2se+ULVyqySSDOtCA2OQWK0xP1NK9qDu3uSX5HgouhcDLqlP+ntzzH8+
 JmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nk9Kfq+lFXIuUyv6rUnoRt8untRd58WuQSEUSLnKwO8=;
 fh=pehpfKBi2MYtoKwB0H7d1RKmf8rIVwch7XKebDHivPE=;
 b=jpQfUBkRCpPC9JKRQ3Vws+khHHxoag3q1fCs3QyyGXzVd6rgjiYcADOIZ9vVY5Rw3G
 lp0MU8f71oLeppZQEqIVfbQCF+pywOqgOKesqFWSVOKqBKu3qN8XNu9EPWTerA5Cm1aG
 m9+4tsleZcjFdw2XP+VxpwA9EOrEQjRdorvJ/U2LSnxbRUeiR8wAz9vHJrHXPcQITDTi
 Dh58r3svESXWaaV4BDhC78T0uRU6qLxGBoAKB+OoYosCpTjrzKS2EcworU6p7ax7inHF
 LExMekIYqJ/Ugx4ooO1zU31Pe7DLlkmqWrr3seSZI+dx5FsIHKaC1O/1OCnTG6EFlTc/
 w1Fw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789614119; x=1790218919;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nk9Kfq+lFXIuUyv6rUnoRt8untRd58WuQSEUSLnKwO8=;
 b=nby+e8w33dhbbaQxil7G0kccVWedEfttp8QBeRiu0qGSnv8kfvpyXqvngPqpv5P83L
 iBD0UfuYInIe57dxzaYnYM83+fe4NKODFQDLZaekAtsfWJVy5HPSEEFuTp50Wl3hJGDh
 vLHCLHPq010wlA7ltdSM6rQBEGdeWnbIoA2o5PgUd3EWiEWqu+usDez2FLTVSTESGhtf
 82FfS46XSw7Sqkgi3LShjQ2jJuZPRc7ECvLrJomCecAephfimhkf7MmLMTFpQINhGYwi
 lv3P5DxGJtEAnvhROumm1TtEIDByQucLd9P64ZoXlDoaOFfA5ii3MsoetVkpJjOrQJYc
 Ki9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789614119; x=1790218919;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nk9Kfq+lFXIuUyv6rUnoRt8untRd58WuQSEUSLnKwO8=;
 b=S2CLhkqy4w/MxQcXy6v2UVNkCErP0gWRJH0FF6QcWM5LtB+gEB2VjvEhUaLYeby3/T
 d6Ixzl+uDqc4hVmtfpaKG9e/mo34PlA/JcxLfNuiWKx3G2zVJIuzzlmy/kmqKEJ3t26t
 Io9oUB6ATylS36pJ2v51zUG8Lm9LRy3lWCoiXBFtEJKT6fVeOMNvQohH3qHH02/iaIiy
 wKUkMZAgNkHQlWKNufbExV+UTP2VDG/XlHGb67xKDWS31H01/AvQOfWCbsSoES50fsoC
 KLbMFuiMcBytPY3YFcFwvpKnVzEzcQLe6cvLRhcnsjaAJJNUtlzvGipPT23DXzQsou6m
 Q8aA==
X-Gm-Message-State: AFuF++nGrotwtsFR5dm1Duokd8+vOGx5Z+IpP4EuZ7BgDXkLCDvMt799
 j236d4g/Tx64GMgv27zpMy8dz+JEuLAhS2wZjLdKZLHhH1n0FRzWpXhurUGUCt11RbM6qUxtanv
 ImesZIZm1VbwAkNz1B/kkJvP/2fhDCZ4=
X-Gm-Gg: AYBFou1BofLiTmXk1l3wsZ3Nu378w6C+iKmoEri+x8xyaE507lePYty9jw86LCy7ns0
 fixxiqeWvys9LerGPJ2uBqbkrpSrQSUiMwCHAsRyEXlTLB0I67kLbQ0DUKYA48wijq1qAWxQi/t
 zfjMo7TXxa2yMRFSHAeB+tSs2+e2+RDgQ+6BdMlnMsWsLJHrvIJYlkjSwKnCTENQYb2tmdwOrnD
 AnkPv36UbM2VpqakXap8uHI55gejH1nzjQW8RXYeDFw72KKnBI7Gkp5MtHjRakyHX+2veFTiN0A
 4NqDvIAJR/JkGefFxLlrgDIRjomVIqn16YYQQ9avwMJV02/KQgtDFgaz
X-Received: by 2002:a05:690c:a0c4:b0:873:5bd1:98b5 with SMTP id
 00721157ae682-892247abec6mr13930377b3.39.1789614119269; Wed, 16 Sep 2026
 20:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-spi_nor_protected-v1-1-80a925329712@gmail.com>
 <528baded710e4e42ac12d0ba657d9237@infineon.com>
In-Reply-To: <528baded710e4e42ac12d0ba657d9237@infineon.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 16 Sep 2026 20:01:47 -0700
X-Gm-Features: AcwNN1UWfpztMFK4lWhKa6IdWIgZi2ow8AuU0Y8ocm74mx8ewxrqTCDCdjvWAGQ
Message-ID: <CAJaLiFxQ_A2JUO4XdAyu4oXTEJD=wTqHV1b8uZi-RgNK1k5fbA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi: update spi-nor protected property for some
 flash types
To: Takahiro.Kuwano@infineon.com
Cc: u-boot@lists.u-boot-project.org, vigneshr@ti.com, trini@konsulko.com, 
 ssunkkan@gmail.com, flaviu.nistor@gmail.com, jeyu@issi.com, 
 dlechner@baylibre.com
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

Hi Takahiro,

On Tue, Sep 15, 2026 at 6:08=E2=80=AFPM <Takahiro.Kuwano@infineon.com> wrot=
e:
>
> Hi,
>
> > Add protected property for SPI flash mx25l4005a, mx25l3205d, mx25l6405d=
,
> > and  m25p32.
> > This will enable spi_nor_init() to unlock these SPI flash automatically=
.
>
> Please make sure the locking feature works properly with the HAS_LOCK fla=
g
> enabled. The HAS_LOCK flag should not be added just to support startup
> unlocking.

Of course you're right. My patch description should have mentioned the
datasheets and the tests that I've done to verify the locking feature
is working. I was about to send in a V2 patch, but realized that we
have a related issue in the saveenv command. If the SPI flash is
*locked*, the user can change envs and saveenv behaves like the flash
was updated and saved, but in reality it was not saved.  I think I
will track that down before sending the V2 version of this patch.

Thanks,
Tony
