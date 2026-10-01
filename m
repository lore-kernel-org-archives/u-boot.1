Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF34CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C37B60C00;
	Thu,  1 Oct 2026 16:03:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0LBISYEcdPVc; Thu,  1 Oct 2026 16:03:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4DAE160B18
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870636;
	b=eojRf1y7KZO1MzEpZq1pamlNyrFpWtolPA++h3UUV09b7asQt8qxmw7c2k87bKqn0Zcb
	 3eSLgyG/F5SJxKXnNKYuNGgw8BbZ2v+V0ZFe7N2miVUoDFD8aajmHazIJspETwwI3kh5v
	 jEyiIB0HYFEuINuSMrqNZXlVCYHaP6mHtkyej/lkstBcCwurmFY06BeVvptvc0geXH1Ki
	 xYLUNIkcpLnyIbsXeZeXJUs6dZ2DG/sALSCfOkiO+iRGe/IGQrSNDforkz3yyiEemJqUq
	 8SoVNnfl3I5mNGFpCsi0PteYUaJTp9Zaa/lXQHZXoqvSuKKElq8GtEYlzcuikMipjZw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HGSwtb7l76N+6/n1jXlPOahC/1He2RSO0IKJ96ZqSXM=;
	b=NPnlFe7Jgxl/WtergQ1CoeAs63j/UuMBOpahch84purw5WCbD4sUgwN6O68Y9XCjh3Rm
	 Qfqc4XBWqStsU7DxfgRoCs/8qbafwQNz2v9sjG88AVXJlmSzj9KJqwwDocWhPE9aPI7nb
	 FdlIZE6gPnflryDKkOUIyNOUs75z/BFgTbH3PV2CE12eca3KaE3xJYrVA/lD3E1kZg5Fc
	 7YadmMrz5qRl1ixqij/ptiLZIZm4Nagl+/eX965Rw/UfykdOLSdqXAmH9my2j/vEciU4a
	 dkYtXJXEfqAlh0A5cH/h6ro5U8R9/JTekWV1PlPIXntexqrT70T2SB7v2i5fBDfUFdQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870636;
	bh=HGSwtb7l76N+6/n1jXlPOahC/1He2RSO0IKJ96ZqSXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tP6oZX6+YGlk2imTw8QevorN0ETH0PpVoQ5w7KwHMLHGc9j99Abg2skEEk3zpusCw
	 fWp8pwH/il67DFcQeLag9oO+ErdQ/RUf9xXMKIFTIeJCrOfe/ZitldlSR4RVr1L6VC
	 Qd+R7bXlncy9L+qLq79lwk6Nh4t2KFMcnqxtByYYjWy3B/1sLMkaDBdaxrTeR6IXt6
	 EjcU2s/8BnVq/qXkJcQKuEh79XyyjYkO23xcaZLul+QsexoLoUnG046V+nIRXC1Ojc
	 cjJ9ugdLcCZsozkb4EPjsbwl6HZyu8m19s4ooo1dATcjW8+UsB6TUO/pZvkQZcTP24
	 hgLiGGFt/PWxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DAE160B18;
	Thu,  1 Oct 2026 16:03:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B0B282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13F0D407CA
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDo_gFwPuQCJ for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:03:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4AB09407C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870634;
 b=qgUjth4Q9mDCuy2rCugMi2Yamj3IH8uP8gOjgBNuqGNRfrY46n9nGCu3CwWEmGRUpFZr
 GYAP79ZLQ3rcU07+ThHg4grLViLSbXCFYEzg8M1OnQfbkgQYPl2iLBhp9c2j3FrVFA2po
 B8dtodXXO6fI+cQavQGYcw7IUm5WfdVuhCjDNMLXSFSXWRt9hH5lFZ3NlS0FQPQLy5+4q
 Bu7/bneMEp9gq+a4kBVQIPqLnqF8doY0TGMgwZtxzuiZWtSPghAq9YAeRsN+Vi4LwnkZS
 1evAcxzO4+bSxXjcB4zc5FYuLx0OAmBR7KQgCHPcdO9VmTnEToylRuYUTV3sO2ReTLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870634;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=HGSwtb7l76N+6/n1jXlPOahC/1He2RSO0IKJ96ZqSXM=;
 b=OG3F9++AL6T/7PjiY7TZwaXys1/bnmmP9sfz4/pHW3mUUk1/ZZLgCtcH3IrYqS1KHhla
 JomWZphE0IXP2WoNvJ55I8kzv+8xOSh7sqd9JCuTLvvCetRxtgLVcPx7z9W762Wfw3AdJ
 juu5L7YhxtX5ZSHcRXApnqFJGah7diWkfjfCY11oIlCxYt/WYKc+pCZvgrpmobSqeMwML
 QRLSpTfQcFx3xKAJ6ACg3fgolLmJGAexrHilPVqsdkwKZl0HbnP5Zx50EYvXDTURoAT63
 QtpCBjNI940DjM+DrhTVN4uw8cBfv6oPR/yQB4zfiiKfJhmgBdkGs4+lG+7+izbVOHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=STqTCBkO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=STqTCBkO
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AB09407C4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:03:53 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso4279948a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870633; cv=none;
 d=google.com; s=arc-20260327;
 b=s0Jiy+MxPysTo5LQTiCnO1yaQvd9/VHJ7WwFp10x4Jb5+NxGrxBECwCacKkyQe0kgE
 y7c6+xyww0VUCDFp3HP4moDd3XO0YM1Evgqg4Bk1PjC79a2D615fQeBbEn+SimV/YQn1
 /ZX2nf/3y7OXXlV11msv7ZSEphjCUvVoJjDbM4CtJHnbMj/ObXTi9TiyhHrWXxt76RZb
 zRw35rH8Ko/QuthTyQzjF1uhb+KcwLtwZj6rP8VsMGsZ7LBtcQJBU1h8UFDusQWX4F14
 N6mOix/glw2Y2rS7NaHB3Ngb04jh3NjJTkqkFZw1TDD2jDHd9E2tHojbyTK7//4gqTyk
 st4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HGSwtb7l76N+6/n1jXlPOahC/1He2RSO0IKJ96ZqSXM=;
 fh=fQX5ZAeuhCKUo8KVcPbZvLDIDPbYQcAH1nXwoTEtCHQ=;
 b=Zb9bH+PXDpXQh6KXnJTY6pt2j1qWr5Ho4RkcRXhsCKqJG5Lv2x6CiQisjXQ/9Wvkex
 hnr4VPmqYLUYP9ImXksJWaEQLovD1OQayE9e7oILWF1OL6UYdyjHDpG87xwP7BoH8lJZ
 HA7QKuFUXsdgD1PeNXfiqAiWBF7lNdRt5dti/4GMr8+2HJf0sUlGR6i2kHaLPNo+O1cL
 Mm7nJz21sXwCRVDZh7LT52UnYqa01jqgVeAh99iLVKOvXpAw/Pj+TsWkBN+gnpOGCkp/
 tDP0jPeQN/NpK09zexwkhlwmd82W5dGlC7fyVzy71V8Vk6xETQCu2RsSNla/Ng3FHzR3
 Zm0w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870633; x=1791475433;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HGSwtb7l76N+6/n1jXlPOahC/1He2RSO0IKJ96ZqSXM=;
 b=STqTCBkOhqixxx0vv/ol1F4A8ihgkRTwRWXH5ejXI0NpsX+iNOmXS0TBh8OwnoBo9R
 FpwUmEDs2wWIo3PQiu+LgQZP9zfdXBRfXjXPyg+H0FASS0PwWf2sZRwi11WmowRtXUem
 KISTJP/czhjC9k6zmwlVX3OmppX5qIHzT2hj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870633; x=1791475433;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HGSwtb7l76N+6/n1jXlPOahC/1He2RSO0IKJ96ZqSXM=;
 b=f1rC7vFBNnt+rDeYZGEb0L3DzN9PWkYECQJ6mBfP8k8jagVZsPEsD8V3UQXialNtE+
 2W4LfibJATLrqjOAfokRlZ/JyykcZViuONELtaGoTPwePw7O0nDz3hy/QvyiYm4YQIgV
 MByfKz/Qhxm76893eC8A99clPKhKFAYkTNkZjbF7qYFte5quzJjmgs40FWriKJsYsmQX
 ikkCQR6KMNVNEhE2HkWS1vBcYhvg9u2kuiTyOhmh7jAyF6qw0+e36Ub4NUAPWCLd6OjT
 1bMyDJKOnkjoMFbio8dIZ+oZorjSYVvK1ctWUbj24W7s/W0kmgwvYIhHRp9fYtPX2kwx
 3jLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2ljX31Tm4T9KJTWkSJXzAR5zwrrV5P358ApQRS0gABQp7hkJRr/oPo9Ip7NtxPdmKeUteJvw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJdMDV3TX+cIJC2A2uX5Y11hofPKYC4PT5OuhmUU+GFGAHhCV7V
 PSAwX0mGs98FjkoIK3QiRsCbtOMbSuFP0v7xzHb4bbFU/Nfwj8Z43fKKY3hJtpTIY3rTjszAyRt
 8BJ5ruRzhMCfExzhCnU86cpBLWI57YhfBDzPdR+sg
X-Gm-Gg: AYBFou2JUeEA0DeB7SGVVeVwucnyGq14l0p/HIKzYh0pUPkFdv3oRe4b1xdeyEJeVtE
 MnjC4dAIfXGCfoAY6+VxRomwibABdyO9Hyd76yYKFwB3POqD+EQRsC9SYlxdNnOWcrtu4RKKX0p
 sJE+apXl5c+FudF8dwUga9b85JqKQPCkUGZnVMn8BEY3DMgkRMG7g2pVaOHKkp9cpxs5z70IUd3
 N8XouAiv+ztEeW5U0jrkyLcYDH6HRGK+1TOXL63wYlxEWFEI46QT6gHT+1zhKnNUhYjpjzmImSX
 NahuaIOhQxWNdTx+n0XxoGXukBOeO6DzrQHkqMokoDBmtdcVdi6SO3Gl
X-Received: by 2002:a17:90b:58c5:b0:3a4:961d:3a56 with SMTP id
 98e67ed59e1d1-3a6cec13ac3mr25896a91.35.1790870632880; Thu, 01 Oct 2026
 09:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260930090512.52342-1-michael.haener@siemens.com>
 <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
 <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
In-Reply-To: <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:03:31 +0100
X-Gm-Features: AclHuK_LDlcSS6lJUJdKOMVYYQ4WBYtFqf9lyMi5nEnpJFRMqp4kBRkKKzRCdPI
Message-ID: <CAFLszTgXVSKxOhdmgGqUG=YEyekP=3jtz=AtHF4zD8Y_CKY50g@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: michael.haener@siemens.com, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Thu, 1 Oct 2026 at 09:41, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
> Any reason why we can't add this directly to the uclass probe instead?
> According to our docs, the probe is supposed to 'make a device ready
> for use'.

IIRC we talked about that a few years ago. Probing a device is
supposed to get ready for using the hardware, so we typically have a
separate operation to actually talk to it and get it into a particular
state - otherwise just probing the device would take quite a while (it
also means that TPM cannot be used for certain things after init()
unless the board is reset!). The same approach is used by the
keyboard, for example.

But given that this keeps coming up, we could perhaps provide DM
support for this sort of thing - it's not obvious the best way to do
it in a generic way, though. We could have a DM flag and perhaps send
an event that the TPM uclass picks up on?

Regards,
Simon


>
> Cheers
> /Ilias
>
> On Thu, 1 Oct 2026 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Michael,
> >
> > On 2026-09-30T09:05:12, Michael Haener <michael.haener@siemens.com> wrote:
> > > tpm: Add an option to start the TPM during init
> > >
> > > Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> > > sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> > > 'tpm autostart' command does, but it does not depend on a boot script or
> > > on the environment, so it cannot be skipped by a stale or edited env.
> > >
> > > Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
> > > is used (and then only from bootm) or when booting via EFI with
> > > CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> > > uninitialised and the OS has to start it itself, which Linux reports as
> > > "A TPM error (256) occurred attempting the self test". Boards have worked
> > > around this by putting 'tpm autostart' into their environment, see
> > > board/xilinx/zynqmp/zynqmp_kria.env.
> > >
> > > Boards that share one binary between variants with and without a TPM
> > > fitted can enable this safely: when no TPM device is found the startup is
> > > skipped silently.
> > >
> > > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > >
> > > drivers/tpm/Kconfig         | 15 +++++++++++++++
> > >  drivers/tpm/Makefile        |  1 +
> > >  drivers/tpm/tpm_autostart.c | 33 +++++++++++++++++++++++++++++++++
> > >  3 files changed, 49 insertions(+)
> >
> > This seems like a good way to enable the TPM for boards that want it.
> > It would be good to document this somewhere, e.g. where we mention
> > MEASURED_BOOT
> >
> > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > @@ -0,0 +1,33 @@
> > > +     /* A board may share one binary between variants without a TPM. */
> > > +     ret = uclass_first_device_err(UCLASS_TPM, &dev);
> > > +     if (ret) {
> > > +             log_debug("No TPM found (err=%d)\n", ret);
> > > +             return 0;
> > > +     }
> >
> > It seems odd to ignore an error in this case - if the board maintainer
> > says that a TPM must be present, then I would expect U-Boot to fail if
> > it is not.
> >
> > In any case, uclass_first_device_err() also fails when the TPM is in
> > the devicetree but fails to probe, e.g. because of a bus or GPIO-reset
> > problem on a board that has the chip fitted. That is a real fault, but
> > log_debug() hides it. Please can you stay silent only for -ENODEV and
> > use log_warning() for anything else?
> >
> > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > @@ -0,0 +1,33 @@
> > > +     ret = tpm_auto_start(dev);
> > > +     if (ret)
> > > +             log_warning("TPM startup failed (err=%d)\n", ret);
> >
> > tpm_auto_start() returns a u32, which may be a negative errno or a TPM
> > response code (e.g. TPM2_RC_INITIALIZE). A response code printed in
> > decimal from an int is hard to match against the spec, so please use a
> > u32 and %#x here, as report_return_code() does for the tpm command.
> >
> > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > @@ -0,0 +1,33 @@
> > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
> >
> > This is not really a driver, so lib/ (next to tpm_api.c) may be a
> > better home than drivers/tpm. What do you think?
> >
> > Please can you enable this on sandbox and it would be nice to have a
> > test in test/dm/tpm.c, checking that the TPM is started after init and
> > that a missing TPM is handled. Your test could send the event.
> >
> > A full self-test on a TPMv2 can take a noticeable time, so the help
> > should mention that this adds to the boot time on every boot, even
> > when the TPM is not used.
> >
> > BTW, since the commit message mentions
> > board/xilinx/zynqmp/zynqmp_kria.env, you could convert that board in a
> > follow-up patch to show how the option is used.
> >
> > Regards,
> > Simon
