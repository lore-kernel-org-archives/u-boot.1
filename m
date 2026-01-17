Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF6EC98321
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 11:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139AA836AC;
	Sat, 17 Jan 2026 12:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MgHEokGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF42836AC; Sat, 17 Jan 2026 12:11:32 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FB383015
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 12:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6481bd173c0so2617074d50.2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 03:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768648289; x=1769253089;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jau2myyvYsOEAf5/5uZIZmPd7ptLxA526bZ3N4ZyhIg=;
 b=MgHEokGGo/AIakYfHCF2is/2VPqhMtO+aW05vJz/j0XJpd2FeS6sqNXzdDQ4F97zjw
 akcHSaZC0OTcGdE2LiLWp7EgdDIU9njtUnkua3HjhjltWsbgAjmBuVhqZ+lXDiRURY7k
 qFUj6GgtS3Udqwt7mJfbHxNUBmSMnn0IdyUTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768648289; x=1769253089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jau2myyvYsOEAf5/5uZIZmPd7ptLxA526bZ3N4ZyhIg=;
 b=wmk8bqPID+ehuglwtuySrtA0zxnzJevmQ808IRhtcnJuIHiblFlFxKrqE27td5MjaI
 flw5Fyybn43eMX1cFND6PUUaQyHOiHmMw+/0v/1rJYBIXfL2msHbwO5X49H+IV6DAjKZ
 CNRHpTLnZ+/hqY3Onqxvwb8zLyuocaQdj8EjyGLH0zBIwYcC4ykH2zDfhp+3aqWxAW2K
 CO0sb5sj7lARV7OHpvTZBjC1HBan1Q2TOHTa8YqajGJ5bRriagghhFDq9QthlpVNHnlh
 /g0Cxcj849BAfrgBQgM83M+NGcBUDcoOV4G/Fe4fD4dpW5gzoR0HlJa9GmRLjOzceB6b
 /0Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+qVRONjWX4vUrZXrte/Yf5Em1IlqP2+vNQbu+x13pycQPpm/vwNTRZwJqWI3aOkZdm6M/4eQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzbOj+aAd8GrywFqNAjP8VXfKH7kCKLfSymUYUcyvGIIinJzF77
 /NAxyOpH6Ip1PbHGuk7bgtZ3IA/vFc1KJe3W8hU2AW4v1UZwSYW6uutpvIwP3ly3/NXnk5lHXyj
 wXyl3rHsOVEAZruJfel7C2boa0PNDX/ucEbQcyYPqYg==
X-Gm-Gg: AY/fxX4rOF0qAPDmp7258CNbzehWVbNaVSuS22jttTVeOh6izcSuWH/cRl5D4bLG/wU
 1k1zGE6d4M6KbI7v0BdO3KR8SSHaO+q4EXItfHUInnEb93h095lfMhyco98lmKga77ul6MxuKUs
 uNB7ZSydLw81VQ+vNThlT5JVxUo4V/YdSikFDGkCResp5ahqNOTqQR99ngV8z0nhq2vhrc0gvNO
 qWW3dH2bsmnxbmf4DmwlnTc/rvdYzTA4TrHSrrenjFvzQnywjN85rzd7VlSMM2RnbiI/wgn0uZB
 F0lN+qPba9n8FnIBNpbLlMOwfg==
X-Received: by 2002:a05:690e:400a:b0:644:6c79:62d5 with SMTP id
 956f58d0204a3-64917773b82mr4011492d50.83.1768648288681; Sat, 17 Jan 2026
 03:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
 <20251228151824.25667-5-dario.binacchi@amarulasolutions.com>
 <CAHTX3dKhhuA2rbg5fiL3bZcUNJVWLCfJ9Vppr1oEB8v6_6qHDA@mail.gmail.com>
 <CABGWkvqG_6TYTvBb9NrzJpH==Kwd21ADxwOAMpuuF98z62nx5g@mail.gmail.com>
 <10d67e2e-6515-4fb4-bf9a-77e5b0961b7b@monstr.eu>
 <20260112102434.1d352e6f@kmaincent-XPS-13-7390>
In-Reply-To: <20260112102434.1d352e6f@kmaincent-XPS-13-7390>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 17 Jan 2026 12:11:18 +0100
X-Gm-Features: AZwV_QhNK7YTRzDXX3kNW9nYBTbO03WMg2EoZUIv-ACQhPeQFT9pptCmg7mq9BE
Message-ID: <CABGWkvoArBqhSuwLKOn+FyUHaEkVuoSoKq7MHdqM3KE3_t8RGw@mail.gmail.com>
Subject: Re: [PATCH 4/5] tools: Add dumpfwumdata tool for FWU metadata image
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Michal Simek <monstr@monstr.eu>, u-boot@lists.denx.de, 
 linux-amarula@amarulasolutions.com, Daniel Golle <daniel@makrotopia.org>, 
 E Shattow <e@freeshell.de>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Kory,

On Mon, Jan 12, 2026 at 10:24=E2=80=AFAM Kory Maincent
<kory.maincent@bootlin.com> wrote:
>
> On Mon, 12 Jan 2026 10:05:50 +0100
> Michal Simek <monstr@monstr.eu> wrote:
>
> > On 1/11/26 16:17, Dario Binacchi wrote:
> > > Hello Michal,
> > >
> > > On Mon, Jan 5, 2026 at 4:40=E2=80=AFPM Michal Simek <monstr@monstr.eu=
> wrote:
> > >>
> > >> ne 28. 12. 2025 v 16:19 odes=C3=ADlatel Dario Binacchi
> > >> <dario.binacchi@amarulasolutions.com> napsal:
> > >>>
> > >>> Allow reading FWU metadata from userspace.
> > >>>
> > >>> According to [1], after updating the software on bank B, setting
> > >>> active_index to point to it (i. e. 1) and marking it as a Valid ban=
k, it
> > >>> must be possible to read this information from userspace on the nex=
t
> > >>> boot to verify whether the boot chain of bank B succeeded.
> > >>>
> > >>> The metadata must then be updated again, marking the bank as INVALI=
D if
> > >>> the active_index points to bank A (i. e. 0) or as VALID if the boot=
 was
> > >>> successful.
> > >>>
> > >>> To allow reading the active_index and bank state, this new tool has=
 been
> > >>> added.
> > >>>
> > >>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ...
>
> > >>> +}
> > >>> +
> > >>> +static int fwu_read_mdata(struct fwu_mdata *mdata, const char
> > >>> *mdata_file) +{
> > >>> +       FILE *mfile =3D NULL;
> > >>> +       size_t ret, size =3D sizeof(struct fwu_mdata);
> > >>> +
> > >>> +       mfile =3D fopen(mdata_file, "r");
> > >>> +       if (!mfile) {
> > >>> +               fprintf(stderr, "Error: Failed to open %s\n",
> > >>> +                       mdata_file);
> > >>> +               return -1;
> > >>> +       }
> > >>> +
> > >>> +       ret =3D fread(mdata, 1, size, mfile);
> > >>> +       fclose(mfile);
> > >>> +       if (ret !=3D size) {
> > >>> +               fprintf(stderr, "Error: Failed to read from %s\n",
> > >>> +                       mdata_file);
> > >>> +               return -1;
> > >>> +       }
> > >>> +
> > >>> +       return 0;
> > >>> +}
> > >>> +
> > >>> +int main(int argc, char *argv[])
> > >>> +{
> > >>> +       int c, ret;
> > >>> +       struct fwu_mdata mdata;
> > >>> +
> > >>> +       if (argc < 3) {
> > >>> +               print_usage();
> > >>> +               return -EINVAL;
> > >>> +       }
> > >>
> > >> above you have only help and here you are asking for 3 args which
> > >> seems to me wrong.
> > >
> > > Thank you for your review and the feedback on my patch series.
> > > After I sent the series, I realized that this series had previously
> > > been posted:
> > > https://lore.kernel.org/all/20251212-feature_fwumdata-v2-0-ad51572fbe=
79@bootlin.com/.
> > >  From what I understand, it starts from the same need as mine, namely
> > > the implementation of a tool that
> > > allows reading FWU metadata from Linux. My version is definitely more
> > > minimal compared to what Kory
> > > has done.
> > > Therefore, before sending a v2, I think it would be useful to
> > > understand which of the two makes more sense
> > > to move forward with. Could you help me with that? I have also CCed
> > > Kory to keep the discussion shared.
> >
> > Kory's version looks more complete. If Kory is happy to send another ve=
rsion
> > I think you should test it, review it. If he is not going to send v3 I =
think
> > you should merge your series with his and send another version.
>
> Hello,
>
> I was going to ping reviews on my series.
> I will be glad to send a 3rd version but there will be no change from v2 =
as
> nobody reviewed it for now, but if needed I can resend it.
> It would be nice if you review and test it on you side to know if it matc=
h your
> requirements.

I'll be resuming work on swupdate for our STM32MP-based custom board shortl=
y
and will test your series as soon as possible.

Just one question: I was expecting the introduction of a tool to read the
data contained in fwu-metadata. Why does your new tool also add write
functionality, considering that mkfwumdata already exists?

Thanks and regards,

Dario

>
> Regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
