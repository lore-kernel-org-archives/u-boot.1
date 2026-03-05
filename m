Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77766EEF31C
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 08:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C8383FD9;
	Thu,  5 Mar 2026 09:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1Hbxy8ZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FB383FD6; Thu,  5 Mar 2026 09:50:37 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058B383FDE
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 09:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6615c461d3fso388519a12.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 00:50:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772700633; cv=none;
 d=google.com; s=arc-20240605;
 b=A7LQw6f3yovMMhNWcmCWyeD96602PhFYsbQvq5CZGxTAGKq+Vh83cRNe2rpUTm9yQy
 6Av8BWGnk+UNHrJ0CCocPHtClcGqoublolW8zP5NP27EMQsjxCVMMFQzRKpsBFSKR0M2
 OreFzmSdblev0MfiHXs+XVjN0priw9cSGJqcG8PGk5sYvWJLqiSkrd9skev2Ssk8I5Y8
 8fTTQRa36ry8ofHy0wPmpgp/RBdyE2nQuzUmjHLwP/klqK8z0cEgwXJ0FjSYPGdACLd7
 UZ1uyy+NvbURdsxtj1lf1lfB5kYVP50uUpXh7N+a7RwYv2TmrSzp6W8nZM6yeZY0yNPb
 QToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e7bbRM6HdbFGZHM4Cb5lQbBqrtAtyxCvnLjKbZ61zv4=;
 fh=7mdw+v5nq8+FyOe43d7uOomobnWlhsvf9giFNY1o4oY=;
 b=FAKIIrZipg21ler+NdX9WnBbUaRyd9SDsEXfKmCj03CCzw1bxfI2ymqij8Yl9vh7r/
 a9Y71TGLS0EMDrP0NVhNZVClPPLbfyYbo5EfTBvsIFbiQKIVCuQ9jxNAMKi86sh26ymn
 qP6/MlFGZLzmbY32itu3S8J39PXDruy3mVkjBeOiQURdGcRiJQn3eyPXxx2i/GNv0ARU
 fgVsX0jS8SbJSDG9kxWr9KXsmgm0qJyoukOHGdNcGQ1EG5D7pF2xmQQ5QVr7XTGgeYQy
 b8oaA2492naMrcDq9kiNyae3lYrsCVRH2h6aYVl/tVAT7afOPM8MPivTwxOLMdlrojmb
 msIw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772700633; x=1773305433;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7bbRM6HdbFGZHM4Cb5lQbBqrtAtyxCvnLjKbZ61zv4=;
 b=1Hbxy8ZWkD80BAb6ubZuSNKOHZEx/oq3Vbt5I7P3ID/ib+k6FDYIbjcoMxtnL7IKtt
 gl5qIdaC6ONZlO+vIX6q0DWpP3btQl+6WCPu6F1DqBXAgftW9hI/zvdh3KhEyrsFR0lo
 zCzh4UTUziIfoh2TZG/UDuR3DZECnB9YUk5RcjFI1RauqoGKqIearxaRb1MvoSMZX2YR
 DxITxGyS3OB0M4uKAT/ti/5lZ6DjowVeBYN6Epf0tr46usH0WYhw9A60VbZoj1CpSWfz
 +GUn7tdQNqQj1O72Umlb+dh5ExtM0jTwysB5hRBFPUhnKMCP0S3O7JvQ6htS2y7DZxQB
 A5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772700633; x=1773305433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e7bbRM6HdbFGZHM4Cb5lQbBqrtAtyxCvnLjKbZ61zv4=;
 b=r116Zfw5EDWRzh6jAm6/GqPs3fctNOCaxyeMbHRqGB13Ogpff9jtGpzklUT+Y9B1hF
 2dP2jd3obdEqreL4SyfraYXodaAMtZowFooosC0xxee3ManNaQAHwISNtMRGp/DaUead
 YybqQNuGUJ3c3cy2aTKHoseQnFplr0YtQWTUJVR7B4QqyyH8jMMhfz8q6ryPitL0eemo
 //QS7vd+HKr9JW4H53z+YlvHDt38HECnNpL/ALBeIaGZt3fe+ccNSbNlPs6zp0gJFRzz
 GUlGGcz3ZiXOx8Bz24jrxqdwSaT9qZj0Zo34BkH++h+omOndT3nNow1B2Exadm5Qkaz4
 zgeg==
X-Gm-Message-State: AOJu0YzUPhzek0pGGzvT2vRU3zGuM+8ls8XB9fzVjfRElrPeNl5HNRwW
 dhwh2EeLnqoZEs8SMHBvSnFR+B4Q8VolGk6E0FukhAuVYZCRUSZCFcNloWAtyAGqG8d33QU7vRG
 mGol6Qo/K5MQXFMRQHwMhsvWA4LDyrkGmLKW8g7peGg==
X-Gm-Gg: ATEYQzyuS67GgHbCrxV2HEGHF9RnvRVCcp3oQrzgOV3kA3DTygIQS75PR8Gi7WK+jGj
 DjDcWFWrjlGSfHCnbo/7wK5SWESiC5MPgcZ6moiqsdSCX3g3Xwdn7/8KuolxjXM7HVeKUmCpy06
 UIswMAi1YVAOvE7w3bnfwsY8bCfBMSMbgBzmEI/qgKxb+JuIe36ITTU2Sn/zfb1adacTPqsFgz4
 PJppmqjJdaXKc/dToKpFDJcwXGYhylG3oOXkEJ217ErZpCkL0Uw5Aix4tSIjWBEXEKmC9LzvXn6
 QYaAJFu9b/+vnwsUjcZn+atALBMQWf8H1fiXHlgkOv7OSGEemoPcSwIXYolFA0eJMsHNw6WuoKU
 i15+orp59ZS1z+LvVNH8dvZEAStc=
X-Received: by 2002:a17:907:2da5:b0:b8f:d13:dec8 with SMTP id
 a640c23a62f3a-b93f11efb87mr287584966b.22.1772700633267; Thu, 05 Mar 2026
 00:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
 <20260210-ufs-ufs_hba_ops-cleanup-v2-2-dd73da21aa92@baylibre.com>
 <405d7b14-fdb3-4ee6-a986-3951053ff319@linaro.org>
In-Reply-To: <405d7b14-fdb3-4ee6-a986-3951053ff319@linaro.org>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 5 Mar 2026 09:50:04 +0100
X-Gm-Features: AaiRm50QPNLz7kqAhFA36tFer4kO5k7fEzlIIA1-KzQY0sWLdPRAojX92bRp-nE
Message-ID: <CAEHHSvZ03hmGRx8KgfjsvgQgCrZbE76m-=jZNKP=f7-o6Medvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drivers: ufs: add helper for phy_initialization
 callback
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Bryan Brattlof <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com
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

Le mer. 4 mars 2026 =C3=A0 17:17, Neil Armstrong
<neil.armstrong@linaro.org> a =C3=A9crit :
>
> On 2/10/26 17:22, Julien Stephan wrote:
> > Introduce ufshcd_ops_phy_initialization() as a helper for invoking the
> > phy_initialization callback from ufs_hba_ops.
> >
> > This mirrors the existing helper pattern used for other ufs_hba_ops
> > callbacks and keeps the call sites consistent and easier to maintain.
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >   drivers/ufs/ufs-rockchip.c | 10 ++++------
> >   drivers/ufs/ufs.h          |  8 ++++++++
> >   2 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> > index 0384244387d..cad753d5990 100644
> > --- a/drivers/ufs/ufs-rockchip.c
> > +++ b/drivers/ufs/ufs-rockchip.c
> > @@ -30,12 +30,10 @@ static int ufs_rockchip_hce_enable_notify(struct uf=
s_hba *hba,
> >       ufshcd_dme_reset(hba);
> >       ufshcd_dme_enable(hba);
> >
> > -     if (hba->ops->phy_initialization) {
> > -             err =3D hba->ops->phy_initialization(hba);
> > -             if (err)
> > -                     dev_err(hba->dev,
> > -                             "Phy init failed (%d)\n", err);
> > -     }
> > +     ret =3D ufshcd_ops_phy_initialization(hba);
> > +     if (err)
> > +             dev_err(hba->dev,
> > +                     "Phy init failed (%d)\n", err);
>
> So this fails with:
> drivers/ufs/ufs-rockchip.c:32:9: error: 'ret' undeclared (first use in th=
is function)
> 2342
>     32 |         ret =3D ufshcd_ops_phy_initialization(hba);
>
>
> It should probably be: "err =3D"

Hi Neil,

Thank you for catching this. I sent a new version.
Sorry for that.

Julien

>
> I'll drop this serie from the PR, please fix and resend a new version.
>
> Neil
>
> >
> >       return err;
> >   }
> > diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> > index bc839a43704..74125b1ab31 100644
> > --- a/drivers/ufs/ufs.h
> > +++ b/drivers/ufs/ufs.h
> > @@ -756,6 +756,14 @@ static inline int ufshcd_ops_link_startup_notify(s=
truct ufs_hba *hba,
> >       return 0;
> >   }
> >
> > +static inline int ufshcd_ops_phy_initialization(struct ufs_hba *hba)
> > +{
> > +     if (hba->ops && hba->ops->phy_initialization)
> > +             return hba->ops->phy_initialization(hba);
> > +
> > +     return 0;
> > +}
> > +
> >   static inline int ufshcd_vops_device_reset(struct ufs_hba *hba)
> >   {
> >       if (hba->ops && hba->ops->device_reset)
> >
>
