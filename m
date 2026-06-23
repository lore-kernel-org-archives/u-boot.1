Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6816CCDB471
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 20:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE739849C5;
	Tue, 23 Jun 2026 22:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CZ7s9uvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0D3849CE; Tue, 23 Jun 2026 22:16:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D66D849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 22:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782245799; x=1782850599; i=xypron.glpk@gmx.de;
 bh=E/j2T6O5trbiNy13Xs16XiIN12JJWLCTcW9z0un6c7Y=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CZ7s9uvL5t7nZi5F5y8oibbMG5BzQpUYnwcP6Plf/a+D4nrMi3y2OoinhrQ2MK3Q
 q2n0KrFakFNfCMy5XTGIdaWKUo15pen978OEBBF/1ppjA4ajJcs/hqQBlIkzJi6KZ
 9cWPH786mn9yUTnquWifKiZ2sNksefC7oNBeHD3qxnCZgK7QyQ8pVvjpGOWtaCiX3
 jWMSHY/oEYnGXoZ7BadsSfqhAv5Dj3T53yGHFKbcCjNKfaOR8+jmtMi72eqBuRYIb
 qjXRiL62RmXf1FILstJpKAOO1stQz1rGaCwt9cDYrfMWeQNqVJcDM46nTO9MYo+jG
 LvqpkFGTkBKpbn08fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1wSjsS2JvO-00AUM9; Tue, 23
 Jun 2026 22:16:38 +0200
Date: Tue, 23 Jun 2026 22:16:37 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jon Mason <jdmason@kudzu.us>
CC: Jon Mason <jon.mason@arm.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi_loader: move efi_var_seed.o to objtree
User-Agent: Thunderbird for Android
In-Reply-To: <CAPoiz9zGJuhZjGgWTV1dz1mh9KET6zBaL62LB4upooUSNYyj5g@mail.gmail.com>
References: <20260619155857.9665-1-jon.mason@arm.com>
 <FC600559-0FE9-4EA3-B047-F69CEAB64795@gmx.de>
 <CAPoiz9zGJuhZjGgWTV1dz1mh9KET6zBaL62LB4upooUSNYyj5g@mail.gmail.com>
Message-ID: <2C956F19-DD44-4C45-B8B3-05DD4E6DEDA0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T8BIZYQt5bJOugQCKRDZWYwrCJkJMwgbZYGBk3MmzkCRyKC+9zX
 q2r6ddhv1MmQgfvgC4T18+43rR0/mKA3Yr52xI54wNh47dFIbzWrJqACDxPZhtONPvindEC
 Jo/MvLxtGjoKCwKW1CORNGJDIBOZFLvkVjNHrJ4UEVt8/zuVpRFKHqgffEozRQGiQma5lr2
 PN5tnv9+DXFAODcJYiLFQ==
UI-OutboundReport: notjunk:1;M01:P0:xsvy2HNw/wk=;hX5TBO9++HmHXwRL8H9IzkhXdQD
 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
 MBVA6g5O3Ow4/Mg6Dg=
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

Am 23=2E Juni 2026 21:03:38 MESZ schrieb Jon Mason <jdmason@kudzu=2Eus>:
>On Fri, Jun 19, 2026 at 12:46=E2=80=AFPM Heinrich Schuchardt <xypron=2Egl=
pk@gmx=2Ede> wrote:
>>
>> Am 19=2E Juni 2026 17:58:57 MESZ schrieb Jon Mason <jon=2Emason@arm=2Ec=
om>:
>> >With commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
>> >(kbuild: Bump the build system to 6=2E1), there is an issue when tryin=
g to
>> >build out of tree, where efi_var_seed=2ES wants ubootefi=2Evar to be i=
n the
>> >object tree, but lib/efi_loader/efi_var_seed=2Eo wants ubootefi=2Evar =
to be
>> >in the source tree=2E
>>
>> Ubootefi=2Evar is an optional file with the EFI security database=2E Wh=
y would you ever put it into the build directory?
>
>I didn't know that was a limitation=2E
>
>Would you prefer that I make a change like:
>-$(obj)/efi_var_seed=2Eo: $(srctree)/$(EFI_VAR_SEED_FILE)
>+$(obj)/efi_var_seed=2Eo: $(srctree)/lib/efi_loader/$(EFI_VAR_SEED_FILE)

Hello Jon,

It is still not clear to me why you want to change this=2E

If you don't like the current default, why wouldn't you change CONFIG_EFI_=
VAR_SEED_FILE in your local =2Econfig file to match the storage location of=
 your seed file?

Best regards

Heinrich


>
>This seems to work for my use case, and still keeps it in the src directo=
ry=2E
>
>Thanks,
>Jon
>
>>
>> Heinrich
>>
>> >
>> >If we change efi_var_seed=2Eo to look in the objtree, then it should w=
ork
>> >in both local and out-of-tree=2E  However, it would require anything
>> >previously working to put ubootefi=2Evars to the objtree, but it's bro=
ken
>> >now anyway=2E
>> >
>> >Signed-off-by: Jon Mason <jon=2Emason@arm=2Ecom>
>> >---
>> > lib/efi_loader/Makefile | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> >index f490081f6542=2E=2E9c836f6ee237 100644
>> >--- a/lib/efi_loader/Makefile
>> >+++ b/lib/efi_loader/Makefile
>> >@@ -74,7 +74,7 @@ obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance=2Eo
>> > obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support=2Eo
>> >
>> > EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>> >-$(obj)/efi_var_seed=2Eo: $(srctree)/$(EFI_VAR_SEED_FILE)
>> >+$(obj)/efi_var_seed=2Eo: $(objtree)/$(EFI_VAR_SEED_FILE)
>> >
>> > ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
>> > capsule_crt_path=3D($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))=
)
>>

