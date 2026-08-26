Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CC1C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 15:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD10E402D4;
	Wed, 26 Aug 2026 15:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bDAlrwDObmN4; Wed, 26 Aug 2026 15:17:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787757454;
	bh=b3YQQcXVGhDd8fJp9LqG2DaMkzeVTTczKpjiXk6ORYQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MUOf/3kXGMLPouDK+dyX3G+lr9MPVLEVMllFJF7xCi0RBLdkdnNC0oLF3mGWtfbhh
	 yXZnAI0urXadYs4Zu8BWZcFPKkvD1UUJF2lQ1No/6rM8MWnNCRKiY9UKGtYH3ruMwZ
	 2mlo8q9mlW7OuduEHMviU0pmHE3C96MvKusrTdx7xx6HcXlDLxG5NZeri5Xt4a3Cqv
	 l9K+K4ckx4S2dPaEeXyM34dHGmShNSpY/Lq8lpffFCWaekRiTWsyL9yZFGtIcWckU0
	 eUy0fnF4FAO3O9bu5dy1iqDQ7Fb9LKNBZ94X28I+DLOqyaKUgX3oz1hSHTNoHjwXTm
	 xjwfVYE8/4DdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00C1A402ED;
	Wed, 26 Aug 2026 15:17:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F3326334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0E04404F2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bLzt4Oe3XFhh for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 15:16:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=k50P260C
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp4.osuosl.org (Postfix) with ESMTPS id 963A3404C9
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787757378; bh=b3YQQcXVGhDd8fJp9LqG2DaMkzeVTTczKpjiXk6ORYQ=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To:From:Subject:Reply-To;
 b=k50P260CRb0pHtZh5t+bPtWfurYqjQ1mtaBzFB94WWRH6WJ0t/tsM45odgLAkDt1BC9+euMgVeCS/r4J28Nh+YKBCQbYlx5puh1UwvfYmfNZj4uiah66E2BICj00O9DxJ6HJjhYQ97LHEDZwa9sfMb/ubP11z/TdCIK4mXlvWqv/UN7ojeSw0pT2+gCbplqnFQm1+QW+/cJcxgUMxy1hY0JSdZtnLjLNDsE22+LM1TSUTofNZCfGXF50rlTxfo14/t0BcGW9xSyq4KyV0LYvqVMErRTUBVFa8osnqSLTe6GFBnPitiy7Kd2qvkyqKbSMdl9kgilKni1IiUgWrx8uLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787757378; bh=VZ5kItKNzDrjKNR1jV+rWdM81G75Q+eGJtlZ8Sr+pTI=;
 h=X-Sonic-MF:Subject:From:Date:To:From:Subject;
 b=WdZg/CavYDdz1RgKkWDwyBkV2HOYtuHh63mBxHdYy2kBen4tSLlTtVtFa5pxIjfUVuQmd4sMHsTdKpVA8281A0In7+uJnohFDvMPLR/nePy+cLwJsVwZy4s3PQJwYyA8ODdeNgGbrwvp8rvljRjC5VcCToyMgRIHo540lFGFyacfs3oPNfWviEDa7RN8B3UY4wPkb+yjJXl9/ACBCFWiQ3O7WbKhRMhIWssTrTC+AOGH5KinFQFfAv5yFoREU2GHy9E99lxtFHnFIBnqnGMDFrTtj6tUvPwAnfRlvQSxFR3+rYa2UTr7f0mXTpAceyPHCB+WcZqz3C+VJYHlrTd3LA==
X-YMail-OSG: tDSwZQcVM1mOOyq37ISR3qudR1mZa59jdarXppEC2VQmWe66Sqcp_vcg.yJz23u
 irO1sIwfOQSJVaO1lqexRd5KSiwtiCo0KOkNbylbL5dAgjFWwRDc64Qvv1tmruSvoYtQSGvvFs9B
 aLVm9NJF0IRSXuVyWYukFIYU8JLhkjUtXf3OM1v0sfrTQxmhUZ7II4BWnoll.OtpQ.fISgGUdbX_
 OVDCmKJefPW8izEEYXfPcQaosafQKV4rH1lUXdVwtMlOvfuLoDjMwPbDV67fCEBsR2M4dBRjr.r1
 9MCK3zbfTHqNlDGRwIdxxMMFspo63616IH6J_JL6GSvYyWJjdf5VI2wbZILWQm0ghyjMtcORY6AE
 EhYKUdaJRiXrtoCyJeASwn4pCNizuj6DBsBSUUHaqon6rC5PX8mUoxep5NUj68rHZKmme0fQCzCa
 Uf2gH4lYFIGglaW7qVWiBfMAswuqYwlpTO6V38BLZ8BuGSpGh9ujFWdVaJdLcBSfVpP72Lk5X2hl
 ecnovzZ9XK.nLeOkTWVO_OIWApN1FjKSKfSrfU6RINmDyN5DdAVViQN.ub8mC8OblPTDMIzdAgrD
 C60d7fhNNgYl.tw78feN4vLsA5oyLxgYbnu3F8GS_dA1NiQrbV5wuiHMJK4BCDvVyLV1R.bI0s8M
 6BeuiI2PJDgzREYSL28lkQ4nV64uiu5rsdmiHifB3kuTgpY7rmbMjoKdvhOYG3RbWYKFJo7WNPZA
 eOzl_TM34qjwawXiXJp2VFeQVcdCrD3mN5i5nr1nV5j6Yq.xEPI108cu6qSZTMXKqTQwhhPBK3Js
 YrqAODacOYgmqzIHu1xD7HYStZS4ykFHaJe.uBMB.MKWGhCxrDoi3yCGpqJXn4kjkC5JXnSKpyvd
 67x8HsIqD3JZ4NhneS8c5HHKCpwxMOgRgeJccS7HY33LHYwBSbgd5TWJcZIxCeF8pG52OfmANmkR
 jHEJe3Vg5fvfQyjnopZnerwCS3DW6.PA8yRuwX.JvZWNnkf.pB7MDXCEBjJvsHJHEXSLklrLI7tK
 UHYW7fXLCrCzT7m4rfWK3B221ijLATRIEO0.fi3Uise681EFnaNCof9SAoqMPzqtGiQ.sd6E3CmJ
 kNjTT03exkWXR_mpLDHeb5GVlnJhnEGYEycBBCyxOMX1dTxSWs2lUMABD2e7dj5EQ_0VMNvSfD8K
 YD3uJpsrGksTwSrynX2_qm.K3sGYe2xGGuwIG.I1J_SahS.2i4jirH6KZOEq3W7JuEb6sGaWt9fK
 alkoFDQMhkJfz1yEYMACf2tiVTVsXRmxOwIywGxfsMvGqqTah5zIuuzICjjd1JEtiaLbDiCcr2ej
 9GoqQK2rb_IfYWoQtwZWg2VaV4zj_j_7yhPYwKHpfrwqnc5Sm1paAO1TMzCV3rWclN4FJHzu1wYA
 yLcARhMOgV0_rliDaBNMUcvbY4nmNjVcBVbXKwuClpoX2TBtPWUVpwcDnEsfOETiHGJl7v0e8hqs
 GXKwAefmv5tVppwOc1QYYCMJ4C7cUhnYKRfPemhB84HxIP.aOz6RY5l5SkEDceBO_WKxfodLXr42
 EuWG6vrLl63ukAHhPOcqbuzSSAR.7jpcXKW2480Tm5FM5MjIG1ZS50GsjzJ2Mth4Q60UQXDzNxGg
 GuIZCuN0bltLbCCuJevtJtMxZ7l5KpNPniEmPkLU9IclTjBILzdkprX2x3P0UNa8Lt1I7SAQevqV
 XLoW.xNZcB1r4Mip5LSgwJOktzkiyQyC9eLIGoSz5CRuPtIACtp2ghP0zuEVYuIq8g_7z9k7zvMd
 2tHZfeYw3O32ui1AZ1xed9jAJAeu58RjjiTQwnOVP9cOq3vJX2Z2B5Oqaec62NShdaaU6_0kkG4A
 _UALBnUtJJt6rzYkSu7d_FjEuV4k604zwZOd6LDHpM05RraXQtnsJ6OMOpbw2W9jjuaiJop7hs2Y
 P2DBLV0NU9RzTs6kzXU.4Q_5CoevO2JLqYQvsfVvUbWcXVjM-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: cac18dd9-2b0f-4cd4-b4af-3a559b221eb4
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Wed, 26 Aug 2026 15:16:18 +0000
Received: from dip134.lsn.sg3.yahoo.com ([106.10.223.143])
 by hello (SMTP) with SMTP ID b69df04827c7880b0b33b191df87c5e6;
 Wed, 26 Aug 2026 15:16:12 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v1 00/12] mips: add EcoNet/Airoha EN75xx (EN7512/EN7528)
 SoC support
From: AK Sharma <maskachoska@yahoo.com>
In-Reply-To: <20260826150536.GM523975@bill-the-cat>
Date: Wed, 26 Aug 2026 20:46:00 +0530
Cc: Matheus Sampaio Queiroga <srherobrine20@gmail.com>, ansuelsmth@gmail.com,
 daniel.schwierzeck@gmail.com, dario.binacchi@amarulasolutions.com,
 frieder.schrempf@kontron.de, jerome.forissier@arm.com, marex@denx.de,
 michael@amarulasolutions.com, u-boot@lists.u-boot-project.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CC9A9FE-CA61-4917-BE28-ED773461DEF9@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <kSKs4kbLRy20mVMgtwFdmg@gmail.com> <20260826150536.GM523975@bill-the-cat>
To: Tom Rini <trini@konsulko.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-Mailman-Approved-At: Wed, 26 Aug 2026 15:17:32 +0000
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

Please drop this series =E2=80=94 do not apply it. It is derived from =
Matheus Sampaio Queiroga's GPL-2.0+ work in =
github.com/sirherobrine23/en7523_u-boot (the en751221 branch), which I =
submitted without crediting him and without his agreement; it was also =
an early draft, not ready for mainline. I apologize to Matheus and to =
the list. If a corrected series is sent later it will carry proper =
authorship and his sign-off. Sorry for the noise.

Regards,
Ak

> On 26 Aug 2026, at 8:35=E2=80=AFPM, Tom Rini <trini@konsulko.com> =
wrote:
>=20
> On Wed, Aug 26, 2026 at 11:26:18AM -0300, Matheus Sampaio Queiroga =
wrote:
>=20
>> Dude, if you're going to get other people's patchers and not even =
mention that someone else used the base, don't even send the patchers, I =
just made a draft for the SoC en751221 and en7528, on the openwrt forum =
itself I said that the boot was unstable, especially the ethernet of the =
en7528 and the spi0
>=20
> Posting someone elses work violates the rules in
> =
https://docs.u-boot.org/en/latest/develop/sending_patches.html#attributing=
-code-copyrights-signing
> and specifically https://developercertificate.org/
>=20
> --=20
> Tom

