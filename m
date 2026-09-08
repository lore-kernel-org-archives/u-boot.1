Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9264CC79FAD
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 11:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44D16809F6;
	Tue,  8 Sep 2026 11:56:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3XdV07nGSwEO; Tue,  8 Sep 2026 11:56:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 811C280A65
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788868581;
	b=FS6u8ZJDw2Hx9DJWqQQ+2ygGCGvi49cTKEySke481Uo8REyxwUKNkgwnnE+Ajb9M8F3g
	 iZyRN6W7b1LD44MKg8cuMIstLM4e2pxbW6ZQ3LM3m/tCotBT7/MPn+opVprrQWAUZY2JF
	 D6l/EwNqW7hcAKPAdjm/pln80Vy7cSkHIDPo/JjHJzrEsQPPqItNC5X+HxATZAvJnx9MW
	 i2FnfMk4F20RoXoMFs+VinLAVVP9DdISobQbdEtpkerFYvoLBXNRTAi7r12dz31aLvYHS
	 HzGa/Qu4H/qW23i70eHE5MCgfnm4u+AeeLQOrNPEdRrmXtXKuGIS9GGFXBjmVE7F9Qg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788868581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y+czomH2DEJArluaM+U2RandGsHr7aGTisAS5lrQQZE=;
	b=XbALoM/jCrVymAOgAhSOczdvj80eMqLkbzgj9FRk2jipziUZ7I1wfQitUppYBPKn+r/C
	 f11ceesyXLySb8HQdK/my4WFU6epZvV1WKSXEGPQqjVrixxtaKDOwFUuIaEebAUdMLWkr
	 e6k+lNMkoE5h6mEITYfyW13qTtS8j+RhiwnYfSIsAAieF5JPuMggbPgE61GfabLS/FJTb
	 ZXE+0RnMunWFTj5UJHBp5sE+aoh91tCdg+ukXa3qkyeKBZw5tw/jAWbilFBDKvm38QlG0
	 cmr+ZKbquLPlaiBAEeeY28Lu/VTIU1gmOC4C3RdJwHHkBIIuXq6MDmebQzLSEtV8ctw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788868581;
	bh=y+czomH2DEJArluaM+U2RandGsHr7aGTisAS5lrQQZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ENzpboh23MP2KuD69h6BWjjWOLnNSpNMItfC8ZdiF1wgfTPjmWaUzs1krutZK3Y9Z
	 EEY5lRfbw1zGUc1mO6TtYteZNaBBd4pPrYXwj8cxwHvAvIcShanJYRfO2AyL6V5yJi
	 ff9sjA35TLwEiZ7EWWBTZbG4SjI7XHYXi8FweL30wJPZFoDuCqrE0eVFOsVCtY2X0L
	 gwVAEpekS+EcEr0lJf6hIE0AL9qpB1+rufdYz7UJuNDs0WEwAn0XX+k9X6YSCB4OEU
	 Y9OsJLPfrYSzLosOvWeW4ch1G1943FDYdf+qX8Fa6NXdUSrhtVDtUaXtOR/N5u9dpi
	 T9omM8WgI28wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 811C280A65;
	Tue,  8 Sep 2026 11:56:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40DC6AEB
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32E29606F2
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hg0cqDkyqPTz for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 11:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 76595606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788868579;
 b=snHV5dSVVNzJ5nyjnhMbZVJ/+JqgcDrckrrcKS0p9jyGss4S6QZ2FRRdhD4CjL9eP2iX
 JJ/B1gAuN9C6cly84Jw+mzJGcdDV308m6XdSBSsAGMrWyiAfoANrxn2HIHOXReZXw36vF
 QZ3yU8pFS96+nGNp8yVFaRW6iLjEwKiqXqZuAD/nt48FsA4A4UAmACm/WjN12H6REZkIT
 PmXZttlHDMrjIE2NFSDrkSZ5rMUAz9BRjxYsWndxECimyoEs+KaDzFdvGvFLlnqt9wHbS
 GC+bm9WwHCm1wPYUMnLm4mC+4jLhytFUwbAcnW8Ej35MB1m6F4FR6srDk4weEe0d7Mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788868579;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=y+czomH2DEJArluaM+U2RandGsHr7aGTisAS5lrQQZE=;
 b=UqokgYvEhHo/ZdbeoGu24eqgVolabt1G13xqaKewKMKCzvM6IBGaGUm/AIaow091C0Gs
 bigXXNHNu4y4dOu4oHJAW2xqalsqboOtrM/zkUlM0K6qNlEvMNUAfOxnMxT++aongAl3V
 5FSlm+GTKvWZu7uC+K/U69/xJ7CKoW9ZSn4YgOtCKF3eHVcjfstwPzbLJOOjIvCPteXCH
 PyA2rwER6YMbHFAjUTUgGAaoPLno4WUHatJ7AyaF7KDId0ugPeyemYttDW/lzoZdLBuYD
 6Cqhrg6bO3XBtQ2eXstrkJs1QmyJSVu4svp9O7eeo9eA9hQB0JBGtauNsGc/PZ0MbjA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GaEIuS1s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=GaEIuS1s
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76595606CA
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:56:18 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-85aa9c1308dso34844627b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 04:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788868577; cv=none;
 d=google.com; s=arc-20260327;
 b=Wgkl9HAxbZPfX1Kc/9A46dDcz76HQlX7UUkmArpJPmrDaHiVqo+OUM95j9AEzd11xp
 GCs7FJVgcMdZcGIK6wflsmKFYxlyh0cy6O+9TX3tO10ZweaizVFMgyq/XS3Fg6EdvfIe
 oOvlWAGrcWd0uESAaRf6CtSOC0iOAhSJL9ATeUt/S7qTBJtnIs2pgu99EOZDCjG8icDC
 VNrIvXPpEkGAnggPJhSaFXpBDxXPU7ScPcLg+7JEn4ke3duAtmmjaB7Z1XDcEra5BFYf
 dr8Zm6aN9WNQfSFpil7gzcWRgHyLFBoD5XqcWKIa+W581vyIDKuuHcXg9ug/R/JyeEne
 ZC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y+czomH2DEJArluaM+U2RandGsHr7aGTisAS5lrQQZE=;
 fh=tNLf/+MrBZDRr7Ng5fSui9q2ZXbx1IfYZXPMDuKbLt4=;
 b=A3j5guVJdWsC3ZMxS+JRonLsa/t5nQYh6F4suo9/DSfWOeLIip7wZuGEUx+qETZw78
 4FFNWs9sCl/vap86gvMgxoGbfCdoKA57q057+W2geZBrXR1G4YGuQgbpQ7lwYzp6TkjB
 xx1T3gLDL1+RVbvwAYsYNNzx09E86A3YkmxWgHmDByYkcd8PPbKEkx7RIoH2iN/+yYSo
 v8DMoiecwl8FUHabGatpILpMQU9NfwIJQrYQHAqHu4BB9g0qyfXvsb7QQEGcq8c4tVoa
 ZBMqrTLVhr9lwGjpcNWG+CT8uHn7PDLOKQe3nmAvTu357tzGIOcPp/UkoWQjXlVzS05W
 kTlQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788868577; x=1789473377;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y+czomH2DEJArluaM+U2RandGsHr7aGTisAS5lrQQZE=;
 b=GaEIuS1sYZfO0/obmcH1kO1M5GRyKE4/0v/Rb9PTyjtpMMyjAUJftJMVmMz8Fto5wt
 4q3rdXaYb2jW4X0+UA6OPHoCKSOZRO5IxUN6GCr7pD0rMOTikeEzjMBc3DcGqNy/kGOb
 e7z6AJi2rwpg95YuNdsWKpT6/tNmaATP7knwzxJmfq1LJFku12/RxLw7bIdubD4ozWW6
 v3eYRSpNBpQE1pCbEnEasGUTbe2lhI8OL7WIws500dw3RD0JUIQeKuzz0S2g4xLJNDq4
 WfGswASIp4YmtNBqWSFpGqsP0ImPkO9WI6q+VlV1HI9NL2vvo0226KrrxGUSXTnCxKnf
 JQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788868577; x=1789473377;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y+czomH2DEJArluaM+U2RandGsHr7aGTisAS5lrQQZE=;
 b=hR6oAs8kZMLWwcROtVDTmg4bBEVC/zJdmg+cWR6eNuQx6A2FIzx8vDmUMCjuHQ2nWz
 iigBDG2b7QnSMRRStspSRiTN9g+ZLTeQ9NvS2otcBydkmGLwSO1xwMPBJml/y+jYUYji
 HuHIexRXKcaw/EX1mQOazeEadn9Sm/X8jxHoUFZwNNZgGB2/wkgVRHNz1KjNqWMOOG16
 FEB8tGU2s87RV50XQK0jq/koGqprh7AtcakpnXE1mBE6GricGRdVK5SbqN5DHYXg7uht
 Safu7OyI1AOZDtQc2PfDsoh+PyPJSpM8384dytLnL17eCZJgUdcKrVhwPWMFNEa/7otG
 npjw==
X-Gm-Message-State: AFuF++mo2INNwalYdyPoS8exZDpIHsdoJVp1Hpkvulghwmt6aYkx9+hK
 H+yaCpQRaBBNFiTz5ZgLNDJELPxtbHO8H6AciLCsQic/SVJPmuolSGh3W1Cn1QbmhEZykLkb8/2
 1NlmJOwowx4osTq0hfkOavFVudNR98hB//hpRO55YTQ==
X-Gm-Gg: AYBFou3rwUw0Temh4ffGL02zvyeCkRMrlmaOPyzFasz+12RayMWORGPB8cb4D6hFCnn
 KH6h+uu6mrBRIq9Vq7IT2mPfwf4YWmX5cxD8xyoyrsbQLoAIuQkPTgjag7++BhyxLcvI/VVCFlK
 NY2AEnig0hhZDu6p1j3sp0rogluHa9AVoeWX3t0Gq43bgCQSPx2JaKoq3QR21JeewCSeyypSp8c
 6GjGHQsM0fviUutiCff3rcPYTQz3nbH2EaGGkpneck0tSxY2PURhoTKO/Q3PEJ5V/hKK6db55WT
 gsc/qC69Qavr0jGPA9wm/46x0cuMMq0DWlqmx3jqnNh+nuQlac8bE/f+sdMFk5I5secWbsAgtlR
 d7XGM1ueYRv4tI9Ys8gf3/z4UairSLsH9ZBTu3Wjo4/4kG2hFe3WUBn2jnPU7fg1SeGPPECzP/K
 GBXgJJvYabz4HUwHwSA0/YZjeFJF6Kq/u/WZSA/oF31aFl1qAuWs6ZvI+Dv1vT9iIiH1FyMWhzi
 3S8snLHybkdOntsqiUGzEtcViBT+xDyn7U3/8B4xJaUqemezUYDtNm32CIXTZLgpBgefCLH438C
 7SV6sud48W3h2hh0uBzODmQv+i6bf7zD1HboDe0tWUOWPWQvQznCNg96ONYcwQzgb/jZO4Ex8TI
 G4yjgfo5/26i85UPImrzc5HCn/xSzizAvSjHcQtN+1w2/qNHtFbPsxA==
X-Received: by 2002:a05:690c:c01:b0:809:fd83:a88b with SMTP id
 00721157ae682-87125448d2cmr119244807b3.3.1788868576938; Tue, 08 Sep 2026
 04:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <1794934500e5580309f4a8cb064bd035cb9b23d4.1787514446.git.jan.kiszka@siemens.com>
 <DL9R83CX8TMM.196CDRKC99BU2@linaro.org>
 <09a518d9-3d50-4a01-94c3-10369fd31a95@siemens.com>
In-Reply-To: <09a518d9-3d50-4a01-94c3-10369fd31a95@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 14:55:40 +0300
X-Gm-Features: AcwNN1V9lsQt3LrBT_Yuu98RPyc2Obcy-cMxwAQkF5yQ1FEinr8eVkC7KqrQ0wQ
Message-ID: <CAC_iWj+vtrbJSzN9zqsRZDo7g8ev7Y1HwxkMBR1ADmr4jn4efw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tee: optee: Add support for enumerating services
 that only need RPMB
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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

On Tue, 8 Sept 2026 at 13:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 08.09.26 09:25, Ilias Apalodimas wrote:
> > [...]
> >
> > On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
> >> +
> >>  /**
> >>   * struct optee_private - OP-TEE driver private data
> >>   * @rpmb_mmc:               mmc device for the RPMB partition
> >> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> >> index bacced6af6c..f7312d7171c 100644
> >> --- a/drivers/tee/optee/rpmb.c
> >> +++ b/drivers/tee/optee/rpmb.c
> >> @@ -191,3 +191,22 @@ void optee_suppl_rpmb_release(struct udevice *dev)
> >>  {
> >>      release_mmc(dev_get_priv(dev));
> >>  }
> >> +
> >> +void optee_rpmb_available(void)
> >> +{
> >> +    struct udevice *dev;
> >> +    struct uclass *uc;
> >> +    u32 tee_sess;
> >> +
> >> +    uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
> >> +            if (strcmp(dev->driver->name, "optee") != 0)
> >> +                    continue;
> >> +
> >> +            if (optee_open_enum_session(dev, &tee_sess) != 0)
> >> +                    continue;
> >> +
> >> +            optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
> >
> > Will this work if devices are bound but not probed? IOW do we need a device_active() check?
> >
>
> You mean the theoretical case that MMC is probed before optee? Unlikely
> right now but still valid. Let me add that.

Yea, I am not sure if anyone can trigger this with preboot commands
etc, but I think it's better to have it.

Cheers
/Ilias
>
> Jan
>
> >> +
> >> +            tee_close_session(dev, tee_sess);
> >> +    }
> >> +}
> >> diff --git a/include/tee/optee.h b/include/tee/optee.h
> >> index d1194493780..755533b2c0b 100644
> >> --- a/include/tee/optee.h
> >> +++ b/include/tee/optee.h
> >> @@ -74,4 +74,10 @@ static inline bool is_optee_smc_api(void)
> >>  }
> >>  #endif
> >>
> >> +#if defined(CONFIG_OPTEE) && defined(CONFIG_SUPPORT_EMMC_RPMB)
> >> +void optee_rpmb_available(void);
> >> +#else
> >> +static inline void optee_rpmb_available(void) {}
> >> +#endif
> >> +
> >>  #endif /* _OPTEE_H */
> >
> > Thanks
> > /Ilias
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
