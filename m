Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54965C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 07:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69FCA60709;
	Mon, 17 Aug 2026 07:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nL_tY1zbfs-T; Mon, 17 Aug 2026 07:33:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3AF196069A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786952030;
	bh=PTPf0cr9NmcHtNigDRHdUom7rPVXXcTGh+uXJAnOtBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mZgv9XOVHoFw+9deCBXUXdg47ywR4UyeBv+AhO0pdL71idZOy3HZjKXer8wVKFT+p
	 2jWg+TzTiqxjkV5i4z/UwWxOVmftvdFk+E5K6MoxzBmRJNwdwQcERQFP0nCk7Dtpug
	 RtLkaVJOIPswhasJMOMY8g7XDqo6dFC7Ide0lfjomoSkxJ9z0c/fbQ0cuaTkqKd9oh
	 tTUZQpCc3etXFV7QAWKUWmYk6yo4z/YuG/ejb6c4WtolRqa7jCkaYzOWMs2icDhPmB
	 wQQtf5+91l1qgBcX9+2aW711Lopm2ZUZ+AjDsgE3zAhi00PNgrOP3ORZG36t2a95Y/
	 bWQoL6++y8SIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AF196069A;
	Mon, 17 Aug 2026 07:33:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 508D9282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4292080D82
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R3Rd9JGnKMHK for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 07:33:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 434C080D00
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 434C080D00
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dqbPH2F5
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 434C080D00
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:33:45 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so477156466b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 00:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786952024; cv=none;
 d=google.com; s=arc-20260327;
 b=Ie7EAAn9qF/Hn8okId8SSgEtCa5ClrPnq+oQylx+0fQrCSDxIHbvX4IsuwiNpaePn0
 hUtpLZbcpDDzjafJN78TlT/+Rtf4IpC/aK3ZBkKYIBVZ9fSRmlemK8Ezhxa8XWZZXk30
 EmuohsBElsF8DoqbRrUmr3RLVOSNnHI2tjtSLGzqgdCE7EcNeqqIyowmGBDbywDSYDwv
 VzIHC/fDJPagZP0zV2s/RaPNWhRa4LVkB4huOB22EXFC+CqG2RIZaSJphZumCgDcZUVv
 s/Q1Fji8BudlBGnqhqyEmiVs3l5fC36HWEP9dNXORixbfvp9CxHrlx4bv9EwlCg5Btp3
 ToHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PTPf0cr9NmcHtNigDRHdUom7rPVXXcTGh+uXJAnOtBw=;
 fh=oftjkY5JAYKhw7RO8IazdpUQKAzt2rIu2vc1nebJ/7U=;
 b=UgcsL2RccD8SZFB9mo2675xRybAMU7xXSUkM5M8p/NtvdKEvEVwxx2PbJpSx0iAfVZ
 Qvxll5wc7Qa570Nbe6gVj9n23FpiCWnJGVTgSSirc3jpvGOazDobm/txQCoDdgLXE8PJ
 A14yLUF8aL3u/edx8c3fCLje158Iqn+kV/QDvQWDoOs2ZK7JtDa+HG99/uDSq0/x0yOM
 gginKWv8vulIW70jRvGydAYJqUzCLU0EFH8vfuykf89NiiCP1YnHvba1MJjx/dTxXj9N
 Lu5K3VG9B3XvLFccaAdhvKzuS8DoyICaSnXwJ6T3dJBWprlYXoFwpV+Ry91GnQT2cAFP
 ic9A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786952024; x=1787556824;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PTPf0cr9NmcHtNigDRHdUom7rPVXXcTGh+uXJAnOtBw=;
 b=dqbPH2F5jiFcJYaUCFPC3TB1i1iKE/HwQf5zU+RYoPHCkeD74MRfnUuz4tKsRZ3HXU
 SqIAHS9BtH9X6066E9eOPleRzxi8AAnaORf8U8S3/Hyf3wpbGz/HOXuWnvUFAM9cU8nu
 dAP38DVPSlRzk/TcejOF0ZfchCLND8lL3sVdbR44c5lAtXG7DOFUTBEJUGX6Ew5ja76M
 gPExu03XBK0sPoBNeAITRZcCeqJPLYIyGXT/QS4brbvmnJbWxuJrCgteksSy70OJDZVH
 rEiC1kPpGbHdlqLYARoWCPZtOKam0XoLa5VK2ale40yIG+U5JL42Zvb9Ms0TaNaM1nLB
 /94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786952024; x=1787556824;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PTPf0cr9NmcHtNigDRHdUom7rPVXXcTGh+uXJAnOtBw=;
 b=XITCJhzMBKWQT4JYs1wcUEWsv+JaSWx5MLPsTknhk/4/18dTE3cbQMlONiarCi8Hut
 TK4qR73iyRfJnARix2DPN8gEBZpnfckVebdQe76QECTADYB3S3BE+/kNnZTMA6/FFz46
 Ryc20Bg7JChK8tO4FeRdicPMFWFTEP8kiFvtTr34brVe+JGoakSv0AsLuh2+WZWTo2Ut
 fQjRkmcfAxNqc4uDqGHhyJfKJPO0IDo+aS8e2ugDrQ0+Cakg2N0n9ogQy3A3BWMi1EMl
 1y/dPFj9l72B6YZm78Xc0RmEyJR2uWu38P5aIM8m1O/+jYIQ40lL3JLatS4QLtFCvb3o
 IApw==
X-Gm-Message-State: AOJu0YykrZmbXg6Y7yLDYg4AeVuCZ6c/tLql9wFacRRGs7+POd65D+85
 vTYgK1cLbLhRkkuc2e6r1BMiA4n0oxhtqXa5FcE1FOM+rNt6XOfuCRboaXY/FGK8QkM286J3cAn
 TAdI7Z9zt6yRXj2I3WAQgal/+bTcaqXO/zi51LykQ8g==
X-Gm-Gg: AR+sD13KUH6a6kBx17Wf0o3u96MFLe3RagPphebatXJUru0Ga3PUTBHIH/P4VT6eReG
 3yDKJipLzadQtP/Jr9fSOK1+R/21ctnntYWL//6jpREQmkNkWsqZuFcRpw71Z4cxj6j+AmYTv2f
 aC3rAIS3PYM7CjaeDlWe/gD/3yWQCrzO+Ytq1G7+0wzxMbVfGtvodIdYaCxIVhJIXiST/uLuN6B
 gu9Ycp4J96zqSzdZW8I4fz5GSoSzxtrCqay+NePws+WtC//uC/x1+DAh2qVmCppqXT75bjWj8Ev
 ttoazVFthRE3n/73uXEZxIgfBc12ior70rH6lJ7MJsCU65Gtx/L2WwX1ra+N0Per642lOxmRmx2
 q86f/vw/i4pawhpWizRvsT48oLBd74Ma32lkHucE70a3DQOfrkDzg/nyiggemOUXC
X-Received: by 2002:a17:907:6091:b0:c19:611c:fa94 with SMTP id
 a640c23a62f3a-c212aad6c0amr932434666b.27.1786952023346; Mon, 17 Aug 2026
 00:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
 <20260806-improve-logging-on-missing-uclass-v1-1-d477f0054f48@baylibre.com>
 <CAFLszTiW7wZf_TUf-1hjkMGLaEd8GJ1QjUSe4dQugW2aDdOY4Q@mail.gmail.com>
 <CAEHHSvYfBunWje_rJJJkft2guJDod1kFtpsgjuxazQCXcABaag@mail.gmail.com>
 <CAFLszTin8Hx3SMiXJF4Ug7vynUSG_WArqmZA+Hvjh2h1cvq7ww@mail.gmail.com>
In-Reply-To: <CAFLszTin8Hx3SMiXJF4Ug7vynUSG_WArqmZA+Hvjh2h1cvq7ww@mail.gmail.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 17 Aug 2026 09:33:36 +0200
X-Gm-Features: AcwNN1XMO1DNia3SujivTidtRswTmKhXdUDwOdzdFG4jk5vvPh1WbCDuKviF9f8
Message-ID: <CAEHHSvbtJbefwWkpng2O_qRFZdB3pSEhh8poozEs_KvwT7h06w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: improve logging for missing uclass
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, dlechner@baylibre.com
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le ven. 7 ao=C3=BBt 2026 =C3=A0 21:44, Simon Glass <sjg@chromium.org> a =C3=
=A9crit :
>
> Hi Julien,
>
> On Fri, 7 Aug 2026 at 09:33, Julien Stephan <jstephan@baylibre.com> wrote=
:
> >
> > Le jeu. 6 ao=C3=BBt 2026 =C3=A0 19:01, Simon Glass <sjg@chromium.org> a=
 =C3=A9crit :
> > >
> > > Hi Julien,
> > >
> > > On 2026-08-06T13:05:19, Julien Stephan <jstephan@baylibre.com> wrote:
> > > > dm: improve logging for missing uclass
> > > >
> > > > When a uclass definition is missing for an enabled driver, the boar=
d
> > > > cannot boot, and without any extra debug option enabled the followi=
ng
> > > > error is displayed:
> > > >
> > > >   initcall_run_r(): initcall initr_dm() failed ### ERROR ### Please
> > > >   RESET the board ###
> > > >
> > > > There is a debug message using dm_warn(), which is not displayed by
> > > > default.  Since this is a fatal error preventing the board from boo=
ting,
> > > > the log level should be at least ERROR.
> > > >
> > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > >
> > > > drivers/core/uclass.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > > diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
> > > > @@ -60,8 +60,9 @@ static int uclass_add(enum uclass_id id, struct u=
class **ucp)
> > > >       *ucp =3D NULL;
> > > >       uc_drv =3D lists_uclass_lookup(id);
> > > >       if (!uc_drv) {
> > > > -             dm_warn("Cannot find uclass for id %d: please add the=
 UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> > > > -                     id);
> > > > +             log(LOGC_DM, LOGL_ERR,
> > > > +                 "Cannot find uclass for id %d: please add the UCL=
ASS_DRIVER() declaration for this UCLASS_... id\n",
> > > > +                 id);
> > >
> > > This file sets LOG_CATEGORY to LOGC_DM at the top, so log_err() would
> > > be cleaner:
> > >
> > >     log_err("Cannot find uclass for id %d: please add the
> > > UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> > >             id);
> > >
> > > The idea with this was that by returning -EPFNOSUPPORT (unused
> > > elsewhere in U-Boot (he says...)) it would indicate this problem,
> > > without bloating the code with a large message. This code is used in
> > > SPL where code size is at a premium. I don't see the error number
> > > though, which I added here:
> > >
> > > 13123276806 initcall: Adjust the failure message and return value
> > >
> > > Hmm yes it was dropped in the initcall move back to the header file.
> > >
> > > We already have DM_WARN to help people with debugging, so perhaps
> > > instead we should just enable that by default in U-Boot proper?
> > >
> >
> > Hi Simon,
> >
> > I didn't think about the impact on SPL. I understand your point, but I
> > do feel a fatal error deserves a proper message.
> >
> > So what about reducing this long message to something shorter, using
> > log_err() as you suggested:
> >
> > log_err("uclass %d: no UCLASS_DRIVER()\n", id);
> >
> > That keeps a readable, greppable hint while cutting most of the SPL
> > size overhead.
> >
> > I didn't audit all the dm_warn() callers, but enabling DM_WARN by
> > default feels overkill. I suspect several of them are
> > genuinely non-fatal warnings.
> >
> > Otherwise, we could just drop this patch, since patch 2 now prints the
> > -EPFNOSUPPORT value on failure.
> >
> > What do you think?
>
> I tend to agree that a message would be better. But any SPL growth is
> painful...perhaps we could have a Kconfig to control just this case
> (default y in TPL/SPL/Proper) so people can turn it off for
> production?

Hi Simon,

Sorry for my late reply, I was on vacation last week.

I've been thinking about this, and here is my suggestion for you to
review before I send a v2 (not tested yet): convert DM_WARN into a
choice with DM_NONE / DM_ERR / DM_WARN to control the verbosity of
driver model logs. Something like:

drivers/core/Kconfig (same for the SPL/TPL variants):

kconfig
choice
      prompt "Driver model log verbosity"
      depends on DM
      default DM_ERR
      help
        Select which driver model messages are compiled into the binary.
        Each level includes the levels below it. Lower verbosity saves code
        size by compiling the message strings out (useful for production
        builds), while higher verbosity helps with debugging.

config DM_NONE
      bool "No messages"
      help
        Compile out all driver model messages. This gives the smallest code
        size, but a fatal condition gives no hint about its root cause.

config DM_ERR
      bool "Errors"
      help
        Emit driver model error messages via dm_err(), at ERROR level.
        These report fatal conditions that typically prevent the board from
        booting. Warnings are compiled out.

config DM_WARN
      bool "Warnings and errors"
      help
        Emit driver model warnings via dm_warn() (WARNING level) in additio=
n
        to errors. This is the most verbose and uses the most code space.

        Warnings may help with debugging, such as when expected devices do
        not bind correctly.

endchoice

include/dm/util.h:

-#if CONFIG_IS_ENABLED(DM_WARN)
+#if CONFIG_IS_ENABLED(DM_WARN)               /* warnings and errors */
 #define dm_warn(fmt...) log(LOGC_DM, LOGL_WARNING, ##fmt)
-#else
+#define dm_err(fmt...) log(LOGC_DM, LOGL_ERR, ##fmt)
+#elif CONFIG_IS_ENABLED(DM_ERR)              /* errors only */
+#define dm_warn(fmt...) log(LOGC_DM, LOGL_DEBUG, ##fmt)
+#define dm_err(fmt...) log(LOGC_DM, LOGL_ERR, ##fmt)
+#else                                        /* no messages */
 #define dm_warn(fmt...) log(LOGC_DM, LOGL_DEBUG, ##fmt)
+#define dm_err(fmt...) log(LOGC_DM, LOGL_DEBUG, ##fmt)
 #endif

This gives a reusable dm_err() mechanism, and existing dm_warn()
callers keep working: nothing selects DM_WARN, there is no #ifdef
CONFIG_DM_WARN in C (only the CONFIG_IS_ENABLED() above), and a choice
member named DM_WARN is still =3Dy when selected. Only one defconfig
sets CONFIG_DM_WARN=3Dy today, and it still resolves fine (I can refresh
it as part of a v2).

One deliberate change: with default DM_ERR, driver model errors are
now emitted by default, whereas today they are silent unless DM_WARN
is enabled.

While working on this I also noticed that a DM_DEBUG symbol already
exists, and it works completely differently: it adds -DDEBUG directly
in drivers/core/Makefile (proper only), so it's orthogonal to which
log strings get compiled in. My inclination is to leave DM_DEBUG as-is
for now and keep this series focused on the NONE/ERR/WARN choice;
folding it in as a top "debug" tier (and adding a dm_dbg()) could be a
follow-up, since it would change DM_DEBUG's scope and touch the
Makefile. Note that DM_DEBUG and DM_WARN also couldn't both be
selected if it became a choice member.

So, what do you think? Is the DM_NONE / DM_ERR / DM_WARN choice the
right direction? And does leaving DM_DEBUG out of it for now (as a
possible follow-up) sound reasonable, or would you rather see it
unified into the choice from the start?

Cheers,
Julien



>
> Regards,
> SImon
