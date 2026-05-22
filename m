Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE887CD5BAC
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 09:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3057F843B6;
	Fri, 22 May 2026 11:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pY2Y9rTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD508460E; Fri, 22 May 2026 11:13:54 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE771841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c7492a2ceso6302276d50.3
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 02:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779441230; cv=none;
 d=google.com; s=arc-20240605;
 b=LI8Nw+IHtHnTxsaNqedCQ7U6NNq3/43GTVqycw0a66miecQkcAS7tyZWeTLFn5xgEZ
 JYDSW5H3R/4pyD/tZjbM6Q+Uj5+b/YTkyjkUyMzK9iGoKJoPA8UPj4cEYAj3yidhx1SF
 Oi8oR+DIjuP0MiQz2oZNRsLB9dbXr8YqVTHssNTxqDFasAmEm6lV2a0F6jFpxSJyTV44
 T1V7HNsDVY2k8UnPhKP8pnf9JFZaJKuP6ytU0NT3vAvt+FZ6aJwcBTyQ0urgZ3Xdr/lb
 uERmfeXXmN1aP5K2Mz4S51Vauw7XSp8Ao0YUzS3wM0QKotY9juIETdeN+Mlaf+PqD+NS
 rDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Faw8s1yB118GR054d1+7NKoJWvjN7El9mSK6DQKXKo4=;
 fh=cH/dLOUe2TDQ6o0O5udolgtFkMiuK0OoJAsG1290QAg=;
 b=lBU3sF7wR60RhhqHYZGeCsWhkMFJW27FUIuJg8JZPNR3BAqv/dGksasDPi/58hgHcE
 8KMXJtd+ZnG3M4l4DjFM1bzCmj+D8uFkMyNWkmg8TEitaD2kaVcYZcMwrZVGCutNhHTX
 GlyC/AvoEN3PqYOWav1wMYH25Js8gKiPm7uuu7z0ja3jZv6Fsut3b8BVMG/h17pNl+/p
 PJVrX9LT0iG00mu/Ii/O2d7ymzNYBphCw+HPG9EWVj41xU5/v8QTjiwkVnYJYJsvmA13
 iYY6WMOpRI+Fozhzdpso6e6GRp5FUYrjf8iTFO48jZl4wACdYraeotuSDn541t7RkfqF
 n7RA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779441230; x=1780046030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Faw8s1yB118GR054d1+7NKoJWvjN7El9mSK6DQKXKo4=;
 b=pY2Y9rTh9b22fud1cudZQVR3qsiCBOlr9BrusEc/zGQfWRZNWHcNdMvEkXjCKbinQa
 9vF4+RjFV0ibNoSzJeVjzeDXSh7EKehW+gTySBXQqAqH7YIXvlxY9wFQq5mXkPBL8d6F
 5tyFVshJ1iv1u4gG2RErwTeE///j+RwspaSNUvfrVN2Ys8HxpRRfZCDO0MXkScxDuqaa
 S7uM89yxDJAquOA7sAZmphfEy3g5TDRpAlj24Q2r3ullNBgWmiKnp4V/7kfiHJjF3Quj
 a8zj3RIpX+eHF1fsSqr83R3MzBBuIZw0PIw4CTXZJZep3TpI73fwvi1O53qTUpO/CLSt
 fD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779441230; x=1780046030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Faw8s1yB118GR054d1+7NKoJWvjN7El9mSK6DQKXKo4=;
 b=DstIyfGYdqtds4FhI7rc5wR4Pn3eIluitlnuDDoZFV9Ca+QHCNyduz+/b+W19PmPnu
 ENgjb2Gla551KE+o7RscQ+NCccmzioTweJ9n9UuefsHARE+kNUAyaxpbL1kkcvgtmmRr
 OTNa2B4rVuoZGV76I0odgMu7vwB8Djiz4LIRb4txj7U8/hVwM6ydr0+eW+pf2GrTTZ0V
 8Lz73SzXgCQN8r2QY2BOFTawjWEuQxDSZafuESM6hQ+YN8/qgg9Sk84boefqh137M6Mm
 85U0sX9g5hp6VrSwTtSUdr3DfGRxPbtCeIKq4Ohw0VB2aQhBD7G4VEcKXeZ5/4vyp3Ti
 VfvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ908gzYpxw5N3eLdiPkPXB0okKVtwWsZ3VBSsSwmUyCivucsj7XhQtQ1/iEUNGURZbJnPLofyU=@lists.denx.de
X-Gm-Message-State: AOJu0YwV8gAq1MyojMzWC8kBt752m8nTZlEZc0+F8Le8cAj37rIEEF0T
 Lhz5IaYfT1OnJMwl1pwF9Z9V19mfpCX63yImvZdzudyq1KlRPkg8LA3UoXRrU9Du+q1nDLsgUxm
 XibXin3+o3N/Msk1q4RVO9unyCrE7MSnbfycZF4+CnfdEnkGKzRX6
X-Gm-Gg: Acq92OEj/9v0fnGBwwnFZOsBR6ilKHeC17UDV5dhNGd1mwPj0m6DtjXrilQNDjyca2t
 QOBeD04t+DR34mMJHRvNjtHpOcSBr7psiI8rT8UtDS056HwaWK4/t3vS8Yo9EIO/mE2n6MHXxPq
 78NlYDiefsBmc2BKR5aggdG/EynHM/YoJNCOlHwASI/vLLySClKipJw1jsvUyVPrGc5PpxTvI44
 bh4r6gnCZfYOxRB+zxS5oxJg7Sg4n6WQ8hntX1aXrNHg09vjF2hzgE4qsrhhQM6hAZtFDL0Hi/1
 Iq1No3/dOFpO8r2OM/thvTSW0sBEFIMOnhsHEc0VwuesYeIY7kXPDnJn0vyyPU5BnZ1XqJNilpu
 0zDhXhvOAuZAlmRaAiBbbFqMDUTsbZ6Nkp3FMnV9mqCsixlemH5u7VrGqw9HyhEIvYyhv/6Uork
 k0TH0FEsEGAu3hGfpcMtOunbAnAavT3a8MMjb3WuMoJbYpktoiPpvqHdrzTNw/fX9kFMTGT/UZb
 e9RJSbtHGeRT93To8RDy3nWCmvngAfeSrOs7j50+86pThbNVWnAspmye/oviKzk/ZuDmVQKfqol
 kPrE745Rj9bMRakNGbPE8sBU3OwJ4SfRG0OFdrAn/3yrTAT7CK5mS/1Lt+8at2K19k2MpRvYpvZ
 IKhNVmA==
X-Received: by 2002:a05:690e:d53:b0:658:509a:754f with SMTP id
 956f58d0204a3-65ec9672333mr2769866d50.18.1779441230538; Fri, 22 May 2026
 02:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-5-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWjK7JxPaDDe7CZt6O_MdGr-wvVkPLmsXR6Pc9V9JWnigzg@mail.gmail.com>
 <b735e9de-4149-4520-839b-d730bef088cc@oss.qualcomm.com>
In-Reply-To: <b735e9de-4149-4520-839b-d730bef088cc@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 May 2026 12:13:12 +0300
X-Gm-Features: AVHnY4IobaVAmX1K_t5KAFZPcPceCoHuasTEnKq4QDshsnQkarQDg_HHk7axtW8
Message-ID: <CAC_iWjJbESxWHbr7K+98pcvu_B0ZcG3iBdDoRMmutrjZyJP8aQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] configs: qcom: enable FIT capsule support by default
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Balaji

On Fri, 22 May 2026 at 11:48, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Hi Ilias,
>
> On 5/22/2026 12:16 PM, Ilias Apalodimas wrote:
> > Hi Balaji,
> >
> > On Fri, 22 May 2026 at 09:10, Balaji Selvanathan
> > <balaji.selvanathan@oss.qualcomm.com> wrote:
> >> Switch from CONFIG_EFI_CAPSULE_FIRMWARE_RAW to
> >> CONFIG_EFI_CAPSULE_FIRMWARE_FIT in the default Qualcomm
> >> configuration.
> >>
> >> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> >> ---
> >>   configs/qcom_defconfig | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> >> index d0d54ec5a70..25059d2e6b4 100644
> >> --- a/configs/qcom_defconfig
> >> +++ b/configs/qcom_defconfig
> >> @@ -9,7 +9,7 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
> >>   # CONFIG_EFI_HAVE_RUNTIME_RESET is not set
> >>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> >>   CONFIG_EFI_CAPSULE_ON_DISK=y
> >> -CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> >> +CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
> > Why? The reason we added FIT back then is that we lacked capsule
> > authentication. Is there a reason you prfer FIT images in a capsule?
> >
> > Thanks
> > /Ilias
>
> We want to use the existing FIT based framework (in efi_firmware.c),
> where we store binaries of multiple firmware in a single FIT image and
> then we place that FIT image in a capsule's payload. By this way, we can
> update multiple firmware ('s partitions) using a single capsule.
>

I responded to the previous email with similar info. You *can* do this
with raw capsules as well. You can also create a capsule to partially
update any of the firmware components. It all depends on the GUIDs &
data you add to the capsule. I am trying to remove the FIT case for
capsules in the future, since I don't see much benefit of having two
identical solutions. The only thing you have to do for raw capsules is
updated your fw_image struct and add the relevant dfu commands for all
the partitions you intend to update. I'd prefer doing that, unless
there's a clear use case that FIT covers and RAW capsules don't.

Thanks
/Ilias
> Regards,
>
> Balaji
>
> >>   CONFIG_BUTTON_CMD=y
> >>   CONFIG_FIT=y
> >>   CONFIG_FIT_VERBOSE=y
> >>
> >> --
> >> 2.34.1
> >>
