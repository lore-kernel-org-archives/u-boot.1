Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235C606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CAyvNK3Z;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tidOfAVW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EDC480F51;
	Fri,  6 Nov 2026 06:57:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6jSzlvVHHN5; Fri,  6 Nov 2026 06:57:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D6AC80F37
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793948227;
	b=H19NKLrZW2dU4PlUi41hbNdLSdRz+Xkji8AC/Vyjhs6G6DFLOT/I0Mfo33B1RNWLNly2
	 JyHMERSz7F1YYCiyHWajVoTeqZGO/TPQOmbDcGGkoqHlTt6DpjqKAGwqy5Oe1JVo+R7x2
	 idS1o3ZdRdC7J0DF1/NH2MzLhnqusBKfSGiGtTmgTjdeYbZAqB+GOrTvmIy8SO03AKVT+
	 VKbHHbs6LG2HUKHUF/LSE/DuPJTFKQOJOm5Obsv7dslswLZq5rUi5NOjrPIZZvqP3Mlkg
	 DlD9ZdS5UeGy6BfakjYApNSCkOGGRwUxFu1yNpqEWLsIMZhP6KX9Txhzg26VGtXF6PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793948227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0rCjs8vX+24324wJ+FXk8RSCx8ng6JegOZnzds2hrfE=;
	b=Ow0KCgxxlAr1QilzP0TDmL1Vhn1sKvnq7waCr+fKVRhmXJv3M6OblQE8dQdF64hCBe52
	 sqfbTmJ+j8rMkPAP8/XJ0prset30fn5XNQXYrFns7ACxOthi5DJ2JfHi5IqOeijyVkYZn
	 DxUURTCjmAunZHdaZN16NPO1B3aImuZKDxAFoDe+erccLwKNpp3eV24nefCS3u5FOGGWR
	 wzEi/mn03oYzMNnRe5kzGAkS8OnqU7Hu3RTpXSJY8DLbkqnuSBBjbutfsLuKd1NLunNV/
	 ZJBcsrNuVLzNaC54srCa9sOmQLCMSnemREzYLp9z8oDm2uPSstN8TomGuTPQKpIhsXg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tidOfAVW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793948227;
	bh=0rCjs8vX+24324wJ+FXk8RSCx8ng6JegOZnzds2hrfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CAyvNK3Zcy4G+Os2XhTFwWQq5nfC6CnbE6KsuCvQ6COWirvSOVVNh+py63MWymIFw
	 R5Y3+JYIgqNtq2JbySLXsJqqc9iJOkz10ZFwTmK6e1QtPVMCS3nsJJ4yATXciWyOA2
	 MFPZUVTnFvePn/X4oFZ4fg8aGD7QpfEQbo2797FizkgWEM86Ko1L2+xzU2wbNeZmEW
	 sDNcBL/90r6uA2SQBu4rMCwdHh1u3wYn3yKf+TnP0b400gSoETAHMAcNOrGSbMP/86
	 LUoeEFmYCH3TVF7vJ4RKuZjufTBX+KULfIP54H3/TUkkGCvevQyY4uamFTIxkPsLL0
	 yHsn1UNKpSt/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D6AC80F37;
	Fri,  6 Nov 2026 06:57:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60F2132A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A94E80F37
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:57:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ahos1mYgC_HG for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:57:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0DAE80F35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tidOfAVW
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0DAE80F35
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:57:02 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b0d63f60bcso2982647b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793948221; x=1794553021;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0rCjs8vX+24324wJ+FXk8RSCx8ng6JegOZnzds2hrfE=;
 b=tidOfAVWFLKir0X5+5YMjwHyewumDvnP/QUM9QG7id7J5/vYtWzTyhuIsA4KhXsNTB
 Zq3m0cBTDd3n6jwNhqBTp+zgydTZWrC6vwf09rhFnDmsFmGRu+OESv8PIX7iohaCzrtO
 x9E3AxJlLNmq50bkzJGcShooA6zFz2OnljR1TJXB3wAl1p3nFztbAFyhJSIXPwy85Yzs
 haeRmkvuCF4QQ+xRUmexuVAjkjlb7Ch3VnyGrLKEKaOCZXGuc0k87xYSjy2RoIOPVQ5p
 hSkpY05ColALuGWCIYmYKX5+7W2JIVfCFOeseQwExTUlgt3B4YOLoStfAwYnr/c87NqY
 UA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793948221; x=1794553021;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0rCjs8vX+24324wJ+FXk8RSCx8ng6JegOZnzds2hrfE=;
 b=mkkj1DYmja6uD/nZzK2ogtZP8DI7FEfUJ00JR4tRxP4zTcMqIZJbZ9GRa+C3ChKrZg
 c1gMSmQcNK6VMwELzIoh9C5xjLutFw5KZyCl/A3M3cNFzu8xgXHsr1L6HNpEeNI8ksKz
 FLxSs/yg/SpibMAjZJzT/KuijPI6vlBjdrp0Juk1dD8vY9fBqefCj7vyeOmgW1cT376B
 k2uYBHdMSRcDTVZp5aUKYWjg64OOlA1RMAtgboTwf6h9WGDSfEK7GXb/egXWi/uAyNKg
 83nvu78B2EvWzoFqdMrSpkUI1y438bXgBTzrWdilmLabd53EuogWg9ApTv4nnHaSNbCG
 vGMg==
X-Gm-Message-State: APuU4Z/pX0aTUeP0XvvJugcvZh/5L3VF5ymUnPGryCfWGxi7GHDe1bMk
 +xSJkX3CFd2MAO+KzFG0ubBdssDy6rQAf8EyIM18BYLj0HzP51YwAnKHHq5q+tbBPGZxOdX9x5i
 V6vAacHOHBjK/I6sErCaRZBivegAEoHxTOpxOkPZOiQ==
X-Gm-Gg: AYBFou1GhIt+plZfiOGe6pa1PfVkKlHH0j8tJHsADTFrvOXJPpRVeMw5M7vj4W8D3cJ
 16gTHw/+rLjkngiKoAmEaTbzxbwui2uMlWMyS5/o0G49qacpuKZDcFQW6CBMNCdKW0u4duKNGNB
 TcSRNej137ZkG7zNBuhayT0gt7ZN4vcxn4XwhN1d/FcHMoq0GyA1PEoEyfpjwSiGDBBAOIL+erd
 /Jroxajp4Z/5xSL80pW4XfDRpjikRe48i6UM+vSERTqCY3OrJHSyNhb1tsNao5Hcm2WJcMNBm6V
 pfnv4UAMtZea+HDrtYF5HKgAMIdJdqYh98JyuAAtTnXAnWLOzZqYEWqGrb+5lDc82Dn7BkftlNN
 e1SEjq+RAy9V2Bub5PzI7WUN3mAamxKXFCRCJLVbAR2tY44nBrN216vT7b9tobCAXE7DcbZoJX0
 yx3XOFxSeHkLfCyfdbACciUd8oW+1hB9xECFvxHFh61ik3rPLN4vPho1BYMA2XM8HF60qBFPd9J
 Emj9G6NqFLS2+sxpapE8nkRKCriEM7U36p/UHJBAesaYCSiGNIJx6OLvlxzDdbIh9NaBleUVvF5
 qJECwWrJfhSeWdG8Q+aquRcymFDUGBqbIokh3ZfSNR0cZQvpcLBPwsPMz5fUIWYMdEqSlGpWNrd
 6aHIk5I4UZzrOK4ePm+IInRxf2kAiQJ59h4tRsqvyxCFBZ9+G5omLf61KBs8ZNtA54wlnZDLdqm
 DAaqaYKfgURd+sxbUqKVnLRsYALuBToKlGA38=
X-Received: by 2002:a05:690c:7487:b0:8b3:4911:2dad with SMTP id
 00721157ae682-8b349113693mr2071147b3.30.1793948220987; Thu, 05 Nov 2026
 22:57:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
 <20261029-upstream-optee_rpmb_b4-v4-1-e2e4c5330d37@oss.qualcomm.com>
 <CAC_iWjJDzJVM_5MfXhbmGEPpqQLXRV+Nbt=zSn2mxkGkz33ARQ@mail.gmail.com>
 <CAPzfCAYOfN1N4afCEFnG59gtbHWqqaoDtfassiuC_zUQZMd42g@mail.gmail.com>
In-Reply-To: <CAPzfCAYOfN1N4afCEFnG59gtbHWqqaoDtfassiuC_zUQZMd42g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Nov 2026 08:56:25 +0200
X-Gm-Features: AclHuK9VLLCHAmv73iS9m9SX1sX_RJ15KWX09mUi8cjeS4zqOCtSWM42zcuiTso
Message-ID: <CAC_iWj+mXSyM9j9QTxiSrVH88rff5sOuYGM9P-Lsqsogiz+Axg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] optee: rpmb: select the RPMB partition per request
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 00:21, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> w=
rote:
>
> Hi Ilias,
>
> On Sun, Nov 1, 2026 at 12:18=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Igor,
> >
> > On Thu, 29 Oct 2026 at 17:45, Igor Opaniuk
> > <igor.opaniuk@oss.qualcomm.com> wrote:
> > >
> > > The supplicant switched the eMMC to the RPMB hardware partition when =
the
> > > device was first used and only switched back when the OP-TEE session =
was
> > > released.
> > >  Between two RPMB requests other users of the same device switch
> > > it back to the user area: libavb does so for every partition read whi=
le
> > > verifying a chain, and the Android bootmeth reads boot/vendor_boot ri=
ght
> > > after verification.
> >
> > I am not sure I understand the bug here.  do_call_with_arg() calls
> > optee_suppl_rpmb_release() everytime we return from optee which calls
> > release_mmc(). Jan introduced a nested call on that that would explain
> > the bug?
>
> You're right, and the commit message is wrong. The partition is
> restored every time a call into OP-TEE returns, not when the session is
> released. And tbh I re-tested  both bootmeth with AVB TA (+ also with
> RPMB wiped) and
> separate avb cmds like:  avb read_rb, read_part, verify, write_rb and mmc=
 read,
> without this patch, with only patch 2 on top of master, on QEMU with the =
AVB TA
> and all of it works.
>
> I can no longer reproduce the timeouts and I/O errors
> from the commit message. Seems that they came from a tree with several fi=
xes in
> flight at once, the sdhci status-timeout one among them (which was
> accepted recently),
> and I wrongly attributed them this patch, so I apologize for the noise.

No worries

>
> So please feel free to drop this patch. Patch 2 applies to master on
> its own, and I
> can resend it alone as v5 if you prefer and you don't have objections.

I'll have a look at patch #2 and pick it up if it's ok

Cheers
/Ilias
>
> Thanks
> >
> > >
> > > With RPMB left selected those reads hit the RPMB partition, and the n=
ext
> > > RPMB frames were routed to whatever partition the other user left
> > > selected, which ends in status timeouts and I/O errors (seen with
> > > the AVB TA on QEMU's emulated eMMC).
> > >
> > > Select the RPMB partition around every data request and restore the
> > > previously selected partition afterwards.
> > >
> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > > ---
> > >  drivers/tee/optee/rpmb_emmc.c | 88 +++++++++++++++++++++++++--------=
----------
> > >  1 file changed, 52 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_e=
mmc.c
> > > index 7ae6045511b..d4abc48f764 100644
> > > --- a/drivers/tee/optee/rpmb_emmc.c
> > > +++ b/drivers/tee/optee/rpmb_emmc.c
> > > @@ -42,51 +42,55 @@ struct rpmb_dev_info {
> > >
> > >  static void release_mmc(struct optee_private *priv)
> > >  {
> > > -       int rc;
> > > -
> > >         if (!priv->rpmb_mmc)
> > >                 return;
> > >
> > > -       rc =3D blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id=
,
> > > -                                     priv->rpmb_original_part);
> > > -       if (rc)
> > > -               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> > > -                     __func__, rc);
> > > -
> > >         priv->rpmb_mmc =3D NULL;
> > >  }
> > >
> > > +/*
> > > + * The RPMB hardware partition is selected for the duration of a sin=
gle
> > > + * request only. Between two requests other users of the same eMMC, =
for
> > > + * instance libavb reading the user area while verifying a chain of
> > > + * partitions, switch the device back to the user area. Keeping RPMB
> > > + * selected across requests would make those reads, and the followin=
g RPMB
> > > + * frames, hit the wrong partition. get_mmc() therefore selects the =
RPMB
> > > + * partition on every call, and restore_part() puts the previous one=
 back
> > > + * once the frames have been routed.
> > > + */
> > >  static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
> > >  {
> > >         struct mmc *mmc;
> > >         int rc;
> > >
> > > -       if (priv->rpmb_mmc && priv->rpmb_dev_id =3D=3D dev_id)
> > > -               return priv->rpmb_mmc;
> > > +       if (!priv->rpmb_mmc || priv->rpmb_dev_id !=3D dev_id) {
> > > +               release_mmc(priv);
> > >
> > > -       release_mmc(priv);
> > > +               mmc =3D find_mmc_device(dev_id);
> > > +               if (!mmc) {
> > > +                       debug("Cannot find RPMB device\n");
> > > +                       return NULL;
> > > +               }
> > > +               if (mmc_init(mmc)) {
> > > +                       log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d i=
nit failed\n",
> > > +                           __func__, dev_id);
> > > +                       return NULL;
> > > +               }
> > > +               if (!(mmc->version & MMC_VERSION_MMC)) {
> > > +                       debug("Device id %d is not an eMMC device\n",=
 dev_id);
> > > +                       return NULL;
> > > +               }
> > > +               if (mmc->version < MMC_VERSION_4_41) {
> > > +                       debug("Device id %d: RPMB not supported befor=
e version 4.41\n",
> > > +                             dev_id);
> > > +                       return NULL;
> > > +               }
> > >
> > > -       mmc =3D find_mmc_device(dev_id);
> > > -       if (!mmc) {
> > > -               debug("Cannot find RPMB device\n");
> > > -               return NULL;
> > > -       }
> > > -       if (mmc_init(mmc)) {
> > > -               log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init fail=
ed\n", __func__, dev_id);
> > > -               return NULL;
> > > -       }
> > > -       if (!(mmc->version & MMC_VERSION_MMC)) {
> > > -               debug("Device id %d is not an eMMC device\n", dev_id)=
;
> > > -               return NULL;
> > > -       }
> > > -       if (mmc->version < MMC_VERSION_4_41) {
> > > -               debug("Device id %d: RPMB not supported before versio=
n 4.41\n",
> > > -                     dev_id);
> > > -               return NULL;
> > > +               priv->rpmb_mmc =3D mmc;
> > > +               priv->rpmb_dev_id =3D dev_id;
> > >         }
> > >
> > > -       priv->rpmb_original_part =3D mmc_get_blk_desc(mmc)->hwpart;
> > > -
> > > +       priv->rpmb_original_part =3D mmc_get_blk_desc(priv->rpmb_mmc)=
->hwpart;
> > >         rc =3D blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_=
RPMB);
> > >         if (rc) {
> > >                 debug("Device id %d: cannot select RPMB partition: %d=
\n",
> > > @@ -94,9 +98,18 @@ static struct mmc *get_mmc(struct optee_private *p=
riv, int dev_id)
> > >                 return NULL;
> > >         }
> > >
> > > -       priv->rpmb_mmc =3D mmc;
> > > -       priv->rpmb_dev_id =3D dev_id;
> > > -       return mmc;
> > > +       return priv->rpmb_mmc;
> > > +}
> > > +
> > > +static void restore_part(struct optee_private *priv)
> > > +{
> > > +       int rc;
> > > +
> > > +       rc =3D blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id=
,
> > > +                                     priv->rpmb_original_part);
> > > +       if (rc)
> > > +               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> > > +                     __func__, rc);
> > >  }
> > >
> > >  static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
> > > @@ -130,6 +143,7 @@ static u32 rpmb_process_request(struct optee_priv=
ate *priv, void *req,
> > >  {
> > >         struct rpmb_req *sreq =3D req;
> > >         struct mmc *mmc;
> > > +       int rc;
> > >
> > >         if (req_size < sizeof(*sreq))
> > >                 return TEE_ERROR_BAD_PARAMETERS;
> > > @@ -139,9 +153,11 @@ static u32 rpmb_process_request(struct optee_pri=
vate *priv, void *req,
> > >                 mmc =3D get_mmc(priv, sreq->dev_id);
> > >                 if (!mmc)
> > >                         return TEE_ERROR_ITEM_NOT_FOUND;
> > > -               if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> > > -                                         req_size - sizeof(struct rp=
mb_req),
> > > -                                         rsp, rsp_size))
> > > +               rc =3D mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> > > +                                          req_size - sizeof(struct r=
pmb_req),
> > > +                                          rsp, rsp_size);
> > > +               restore_part(priv);
> > > +               if (rc)
> > >                         return TEE_ERROR_BAD_PARAMETERS;
> > >                 return TEE_SUCCESS;
> > >
> > >
> > > --
> > > 2.53.0
> > >
