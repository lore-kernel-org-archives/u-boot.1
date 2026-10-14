Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1412CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 10:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3109060791;
	Wed, 14 Oct 2026 10:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jpPPiPOibqDl; Wed, 14 Oct 2026 10:17:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71B0F6076B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791973051;
	b=MNjwukHapOtWcVycYDdHFozbKoR6Kqbp/fRKsFUpZIIOx4HbLMU7gDtKspJhACfQa7lM
	 5piI17KLJukVz8iPSJtDosntDpQvL22QC18a+5F8LODt3MSoPjq0fi+u173RRsl4/G0FH
	 zv8ah6oN0nZtasjmq0eVkqhDMtRjxrQpNkR5kMWwHJq16WenMvz1aPPaicjhTIB/AU9Ol
	 M1kFZret2QDGuOZg+2FL15pKKQa7NU9FgGF9XB6fohYEIT88r2bACYUKOWUcBMkmFT2Ik
	 j/bGA1t7fXLOYZxiVFx5ef2lNGsToijYexzdMQW22wEJN93jIpd6gJGBXQqrxeayM5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791973051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JFIHL+ENJB2vQX7SdWyhXsbjeempCZvw0JOpnAtEleA=;
	b=tN2x58wYLPyez63pcmZHdlrhaikEf9Ki8Qj+FkDEV2AnQafeh3zsLNfwEscbd7jfOXUY
	 zRk13m+5wiVXUHxDE8XZd7yROu5B9q6/fxcY7myYBCIPqVROvZU0gKWZvXV1MX3lGV+AG
	 5G8ngrRPVgBt3ofqrpzRQbvjwWjbfxoKKMEvq0B0sfq3xV6/+UBiHXKl18tcwuOMU186J
	 HOujaaRLg7Ilje3/eA1z8NLc+7cpfFrp68KQ5o7gOP0yw7x2iOBHAUhJ+QEPimve6unmZ
	 CtafNkdPBGCfJN3JOSDJ6Fv59YxIOpPxcKsWfY4neO5FBucDAajoSdH3l3uHicW+HNg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791973051;
	bh=JFIHL+ENJB2vQX7SdWyhXsbjeempCZvw0JOpnAtEleA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RSvHN8vwQ4NHiv+LANZj7x4Uibjuh7pUCMWM4GcLLKR8hJ8mlEhGfEnchdnfO6R2J
	 8V8tuODDZl8VjF57QPUwnFz50MAUWKLPTIFbNVlYrE+04C5LD6OnN3gMc/DCAh3dtJ
	 6U8WHB8ngYE//m/g8fiX8/lR+S3ZRw1V42nVGIq941rRmvDmpTe2hbDIcCvNAGMqB5
	 lGZ6sR06jVyvONuRFFZq7BSHdkoiT3vMUi6+61ez71SpYdsTY0aX8FBoad6xfz/s4E
	 oMYC+qlbJUO8rhFWh1ejRdHm0HMtKpbMUlT1l4EJ1QrBUdvxBvR9J7dhAruJGC9MJb
	 6vROBhk0HVtBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71B0F6076B;
	Wed, 14 Oct 2026 10:17:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC03A255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD9E540666
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRo6JFN9paM9 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 10:17:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC1024065F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791973048;
 b=fSmzXsg8bbBdXGq5C9boyF+7/ChNPaIl+90ny4mPIylosJRaGIqaGoqocy/IrAlTavdm
 1JN1gnWIZolFmziFMjVPKWmi5VDAp594Zivs8eiIzM937ZmKKv1aw3vzPWybJJl2f6Na7
 mGK/H31GCN/BH3ycESFBXuVNya8zEPq/0dSLwsBjbI7JNuJ4mMCm2uYCmZguloArTrm6T
 G6tgPSU29N5mMu3luU3j5QIVuKpsrKhOj7Ax0tQg4z/hDrtH2krBYQgfPdV5tb+FzXDiU
 cof7n+UE1lCm42GLk0OFXgM8QA0MskeJmytLzjt7fuLcPyDpA3w6jMuipCXMwHiQgwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791973048;
 h=Received-SPF:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
 Content-Type;
 bh=JFIHL+ENJB2vQX7SdWyhXsbjeempCZvw0JOpnAtEleA=;
 b=Zb9g5KYokrAHWL70bVpFJYdGDLOMS4yH7ZUhVGyZlaabkKubo2D/X/QYgwKb7/orIx3R
 r14bjxgupXYYeCn/BxGuDaJb2zjZTUOfyqGveNNQwfuWnad/eZg7XI/ppqrNMyJvEpYgz
 WnwX6zVG4nLsk7fe9pfxkfkBsWjajilL8PcZiKbHvDr+ZdjGAp+h8EjferV8UJi39dxOa
 6ZSjeNGMe/xNtsaZO9pQsBMmjm4bCfVSPMPEObowS4TxRUmrppyWUK2qJ72wJMCYLmngY
 on3ZvmnZ5Bac2nKCP3vWhQsqdlbTW79acvfgcdb5OLeJla9xI75PYbT8iTWCV55zuuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=rasmusvillemoes.dk;
 dkim=pass header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=ooHAEbCh; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=ooHAEbCh
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC1024065F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1791973034; x=1792232234;
 bh=JFIHL+ENJB2vQX7SdWyhXsbjeempCZvw0JOpnAtEleA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ooHAEbChRG9aVkotVpxXEQnhZLt2nJYepmbt3KRyd3y6Ik9HZTxXAsZZMi4zceN3+
 8WIi/EG4uuK9EnVPww1m6zPHIb4NjAGi3Ssa2tA6ZrAtcxKoMh4gNgCsqNFFMLRGtP
 aeli8uQ0hWBdbv023tV+00G7irhfWKXXk16lRu4D8T8RPfx5sdSxjcRS2WVRQZ8wto
 VFu0gZDy46NkhiqH56qiqWEorh9nbLxBEtgzTA/NSXec64uecsYOn0ko2xpjkNNFHK
 AYrBbNGjU3/UulN0bZkPkiawuI4K/tgpmMvOHK7KJYes5hJHfbKin6bmyOyMiuw9Kq
 L+5HkwdeQjC3A==
X-Pm-Submission-Id: 4j4Rvr2T3Mz1DDXk
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Tom Rini" <trini@konsulko.com>
Cc: <u-boot@lists.u-boot-project.org>,  "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>,  "Simon Glass" <sjg@chromium.org>
Subject: Re: [PATCH] cmd: config: Add additional embedded text option
In-Reply-To: <179192278169.4115168.10731444024331979767.b4-ty@konsulko.com>
References: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
 <MFdJqIFZlw7IIf1Jj2LsvEA5c04izFohJgFJlOWk6AmReo362WRLQeEFh8KgY1DFFup2bV5iyOo06KmvI_2hEw==@protonmail.internalid>
 <179192278169.4115168.10731444024331979767.b4-ty@konsulko.com>
Date: Wed, 14 Oct 2026 12:17:11 +0200
Message-ID: <87pkxc1t94.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Oct 13 2026, "Tom Rini" <trini@konsulko.com> wrote:

> On Tue, 29 Sep 2026 19:31:59 +0200, Marek Vasut wrote:
>
>> Add empty string Kconfig option, which depends on CMD_CONFIG and lets
>> user embed a short piece of text into the U-Boot config, which is then
>> printed by the "config" command as part of the embedded .config.
>>
>> This can be used for example to embed OE /etc/os-release into the U-Boot
>> binary, which can then be used to identify the exact OE build from which
>> the U-Boot build was built from:
>>
>> [...]
>
> Applied to u-boot/main, thanks!
>
> [1/1] cmd: config: Add additional embedded text option
>       commit: 400e46a0df848db66ceaf3ece26786f689789163

Late to the party, but I don't really see how the existing
CONFIG_LOCALVERSION doesn't satisfy the described use case.

Is it because LOCALVERSION is for some inline string meant for inclusion
in the U-Boot banner (i.e. inherently a single line), while this is
meant for some multi-line additional info?

I think gating this on CONFIG_CMD_CONFIG and using the config command to
print it, including the \n escapes, and then pasting that through echo
-e to get those interpreted, is all somewhat roundabout. It seems that
one can obtain the same effect by unconditionally having this config
option, obviously defaulting to the empty string, and then extending
cmd/version.c doing something like

diff --git a/cmd/version.c b/cmd/version.c
index 62406608eb0..ef70087f3f6 100644
--- a/cmd/version.c
+++ b/cmd/version.c
@@ -27,6 +27,10 @@ static int do_version(struct cmd_tbl *cmdtp, int flag, int argc,
 #endif
 #ifdef CONFIG_SYS_COREBOOT
        printf("coreboot-%s (%s)\n", lib_sysinfo.version, lib_sysinfo.build);
+#endif
+#if defined(CONFIG_CMD_CONFIG_EXTRA_TEXT)
+       if (CONFIG_CMD_CONFIG_EXTRA_TEXT[0])
+               puts(CONFIG_CMD_CONFIG_EXTRA_TEXT);
 #endif
        return 0;
 }

Then the extra version info is printed in human-readable form
immediately, and there's no change in the binary size when the string is
empty [*].

So I suggest renaming this option to something that doesn't tie it to
CONFIG_CMD_CONFIG and doing the above - that also makes it usable by
boards that for some reason cannot afford the ~10k increase by enabling
CONFIG_CMD_CONFIG. If it is unconditionally defined, the #if defined
guard above can be dropped. CONFIG_VERSION_EXTRA?
CONFIG_VERSION_FREEFORM? Dunno.

[*] Unfortunately, we build with -fno-builtin, so the compiler
doesn't even recognize strlen("some literal") > 0 as a compile-time
constant.

Rasmus
