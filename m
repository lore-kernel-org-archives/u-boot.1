Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C8DCD3436
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E51A83D13;
	Wed, 12 Nov 2025 18:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VEwocpWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A3E83D18; Wed, 12 Nov 2025 18:50:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D084483CF2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762969850; x=1763574650; i=xypron.glpk@gmx.de;
 bh=fOdfZJE/lb/fA4jrSzP7+J1FW68F3CxqeH2OUMsPYto=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VEwocpWHYpmaMPw4EZE476uFT7mL0MGMp89ez4AWm662X+kyjwoUsjAkXweS+0lY
 DhIZupFzG0iZxOj0gz1bs0Ndiwwyr9+lf40cU9zpU3ToSocATg0JOX9PQ2FyAkPze
 0X0kBNF3m2umnX9x7e7fPOP5FR/n3/t3ChcQhbbvBmsBSc6eZh6oHL0wA1aLcpwpr
 RRPN8q2hghKvs+7cPcGxGFYXYbE92EkYuhGOeU35brv/WSTwjwuLrNYV1d5qt4157
 ZSG4cqzpEi9BfR/zbvjsVIUyCYSXz7bIZSpaqT65OyYdZ1QRf8D/eUBoPZKO6Cuqi
 Giyuck0WJ/sBr6qmLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1w90jX0lbJ-00yEF0; Wed, 12
 Nov 2025 18:50:50 +0100
Date: Wed, 12 Nov 2025 18:50:48 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_test/py=3A_Use_aligned_add?=
 =?US-ASCII?Q?ress_for_overlays_in_=27extension=27_test?=
User-Agent: Thunderbird for Android
In-Reply-To: <20251112152750.GA6688@bill-the-cat>
References: <20251112020230.414101-1-marek.vasut+renesas@mailbox.org>
 <20251112133558.GY6688@bill-the-cat>
 <1933c9fe-22f5-4405-8938-fa28fe89a330@mailbox.org>
 <20251112152750.GA6688@bill-the-cat>
Message-ID: <87732B74-9EFD-4D6D-BB52-52B31BB7923D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:20QdiPxvxXk2fP2qfhqlqrxYtXVBpwVIl2BDWct3MbzckTfQnp+
 zPjQjvOuoCk+SMkPhE68gtBSPCn6hHN7qQkNWGluUA1Xhv9/2RV2VkCyrBnrW36VT8ZdSwg
 TXduidCYw/INNE7wuM/0nXfGoCom4qSwtUq/OOuzMmcvuhmAnrahexZVT8LyFNOXPOGrZ7R
 zrYxr690vPtGyA2N17xOQ==
UI-OutboundReport: notjunk:1;M01:P0:eDjFDNVBWS8=;UV/FiK2w0gBz/6hJPaVM2OnOtsJ
 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
 KWlboJI8=
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 12=2E November 2025 16:27:50 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>On Wed, Nov 12, 2025 at 04:24:34PM +0100, Marek Vasut wrote:
>> On 11/12/25 2:35 PM, Tom Rini wrote:
>> > On Wed, Nov 12, 2025 at 03:02:21AM +0100, Marek Vasut wrote:
>> > > The 'extension' test would set 'extension_overlay_addr' variable to
>> > > decimal 4096 due to conversion in python=2E The 'extension_overlay_=
addr'
>> > > is however sampled using env_get_hex("extension_overlay_addr", 0);
>> > > which converts the 4096 to 0x4096 and uses that as DT overlay addre=
ss,
>> > > which is unaligned=2E Fix this by setting extension_overlay_addr to=
 0x1000
>> > > as intended, which is aligned=2E

Please, do not use fixed address 0x1000 which may not exist on real hardwa=
re=2E

$kernel_addr_r would be more versatile=2E

Best regards

Heinrich


>> > >=20
>> > > Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>
>> > > ---
>> > > Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> > > Cc: Mattijs Korpershoek <mkorpershoek@kernel=2Eorg>
>> > > Cc: Simon Glass <sjg@chromium=2Eorg>
>> > > Cc: Tom Rini <trini@konsulko=2Ecom>
>> > > Cc: u-boot@lists=2Edenx=2Ede
>> > > ---
>> > >   test/py/tests/test_extension=2Epy | 2 +-
>> > >   1 file changed, 1 insertion(+), 1 deletion(-)
>> > >=20
>> > > diff --git a/test/py/tests/test_extension=2Epy b/test/py/tests/test=
_extension=2Epy
>> > > index 61223496054=2E=2Eddc62e7d5ca 100644
>> > > --- a/test/py/tests/test_extension=2Epy
>> > > +++ b/test/py/tests/test_extension=2Epy
>> > > @@ -38,7 +38,7 @@ def test_extension(ubman):
>> > >       assert('overlay1=2Edtbo' in output)
>> > >       ubman=2Erun_command_list([
>> > > -        'setenv extension_overlay_addr %s' % (overlay_addr),
>> > > +        'setenv extension_overlay_addr 0x%x' % (overlay_addr),
>> > >           'setenv extension_overlay_cmd \'host load hostfs - ${exte=
nsion_overlay_addr} %s${extension_overlay_name}\'' % (os=2Epath=2Ejoin(ubma=
n=2Econfig=2Ebuild_dir, OVERLAY_DIR))])
>> > >       output =3D ubman=2Erun_command('extension apply 0')
>> >=20
>> > As we often get patches to remove the "0x" portion, can you just corr=
ect
>> > the format character? Thanks!
>> Do you mean s@0x%x@%x@ in this patch ?
>
>Yes, thanks=2E
>

