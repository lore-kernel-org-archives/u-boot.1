Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E30606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z21gSJxe;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w44IjVl6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC2C080E3A;
	Mon, 23 Nov 2026 13:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DxHXmzzLtI-z; Mon, 23 Nov 2026 13:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B1F7180DE2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795440717;
	b=qFX0oj2aguXMmFoooyIE8HNKa5UonghjI1Xxa9l6/+otS0RM5Oap/WPTgtk4GU4YOaLC
	 xiEyX/awUVCUWGbyoJ7YcHfRvAjIMoTT9OskXjCCRF+eZ0jQLuoL1V3yvNQuZ6pR8Pd79
	 9HHS+I9YFLIb9TPKEdV/R5NE8zmdoiAbYNqD2IFBcL2s9ZvXzu0ZAVNZ5Tn9tW3CXKElT
	 8wLETU8yO3amrvuRM1z+OLWWub6xKuPugKZhGNiHpJCuRd6dCUnOAf82FVSS+Pp9GlwZh
	 tIm/sSQJwUtM9DSEUnQr/RaUmSiK51/VA0Yl94P5NzqvyTcv/r3YFPOF5gnNkpXUPsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t40lSb9jadZ7TDav0UK+z8wpKtUWEvWUqa/gRkCehMo=;
	b=mnH74kNmcXNPk8rHBYzYKkGbO5oZvcZ2jQm2rM8iiwJNkz1hcDTb4qcTX9xL3HSl0Nc2
	 46TWgUN6v/hbM0i6a8+xXcorbUp8lGrKHWLk0qRI7aGWbIWiR1LZuvWdij2vqltfbplZD
	 gQ998xR+OJgsQV4qA+uaHNisfTq5x9oWiNhgsgQEp9mlV/Sbg623BQveQ191kQDss/ejt
	 65en8cdMzSSq1vXkjxYij3+TWmDpblbJz2uM1sDfgoBni3YwcA8vDWkNlj7OyrIQ/jR8F
	 w196GvKBEM2agXpJN/TaMmIApUfCV9mfh3KfRRg/L0pBy0ijAcDqaKQsvq+seuxiN2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795440717;
	bh=t40lSb9jadZ7TDav0UK+z8wpKtUWEvWUqa/gRkCehMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z21gSJxed2+a2rDErwloMbLlD5hiVvwYR7FWPiu61TkY/pdwgrny3rMBLi3T2iV/w
	 8LXl1tdnR5gn4OxaMvKCnYx6YeoRihQix6m3y7OUARrOZ6R4H1Uc4QzZAcV/7r3G+o
	 Ct503YqAlbStfhpwRlbk91r6g3lQRpmzlm3It8+VF5uZ3tAwIunEFHK2+1mI1xcGx1
	 pfW5s5wjUjAEOTWObzOmId/uGnaETAImZgmKd1XjGDD1yytMp5SOCVIUMhLQz1rpoH
	 9K61fb/otGvWgH2SSeIYJkqrgsPweCHTZIgncQQC1HEDFqTm0tNk7Izm8njKvYYKr6
	 Xm6iP9roXnEOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1F7180DE2;
	Mon, 23 Nov 2026 13:31:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AA4913A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9BFB840259
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hAi1RbJ3xW-v for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:31:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3FD9C400BD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=w44IjVl6
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FD9C400BD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:31:54 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c5133831027so468373766b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795440713; x=1796045513;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t40lSb9jadZ7TDav0UK+z8wpKtUWEvWUqa/gRkCehMo=;
 b=w44IjVl6I23LIeGKNSvFLvjoO7sqvTxdvhlF+cIzNxDWK/JF9Eow5yN2D733gJUqxt
 /oTgGZjl0nZQaXaJshmyBFJq2HBTu/h54lpdibYpZOUN1wnJLbuNXkbNIWEwNkvap5uG
 QqEx6WIGkg5lqTrPK0+WL1wwgD12mTXeH4/xx5RHY8HgClUhOlt+qvymXTFEhqGDh0BB
 30+a2Uia5BBMOReJe/VPrOtXU9QlpFXZ/ttZ4sYWnZ1rMZMVN7h+ZnZDv1oqHXNfmQma
 W2n+YYW0UGLd1oLtutB8H5Zz4Y/u2OwnsYss8dbIiik94BGiiJ2yJI+OsxB2iqQQ+TxF
 Tf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440713; x=1796045513;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t40lSb9jadZ7TDav0UK+z8wpKtUWEvWUqa/gRkCehMo=;
 b=TA6MfQ2elOcPnRbmV6ZhR3ZQLnvGjspaeXygJeYuBEj5F3hzcHdImjXTRg+DC24Cxl
 ejtPD9nS0P6Vkhjgxgi6Dmd9FOFwXps3fXh2Re1EAOdvKdZqUpGTGbsu7OmpddvZLUvV
 TVC3X35ke5qngmbvSdqel9g0EnBUZpVB7QFyEH0hlfY4L881unVCspmvYglTtvn0Tgdx
 awTEU+8ccG9iCkCWSgBKN5lG2pYj+f7Jks7lEUAdys/WIfpuKAes1Xl2ENmMm53QXPKN
 kL5Eb+zAgC8TNuszjDvsNJNtISYh/lXH4Bf368G7611J2OBV4t8ac8jmrNRb/dArosTy
 wyZA==
X-Forwarded-Encrypted: i=1;
 AL+hErEXLaBE/TEg9HOmjAHt5iwkfklsj4Pt8JVT6fqz5SVLj9GygHUqp+dwa20ZP9vevvgLmw57a0k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8uUtpkGL2owqNcCfEaw9gNnXLoW7uElMDVusx3bT5SBSbjWO3I
 RSUM5QXhvKzNQRBAQuoTmwt2Q1knlUuaVlbwGByk7OEvueowaSo/xVkMt1Fr0xOUi3o=
X-Gm-Gg: AZFdTZcAOv/d1VycedV7fW/0LK0Lj5/FUzGbyZXkS2opXgVpKIGVSUtOgmMGN7SW3Bt
 RX2xa0MVjGl/EMqbXFtEkiW+iZXgRCgdYQzR9wYsUsHKmQjpxi3tljnlbZD48qEkbKwGSF8zObX
 KowwEsTlzzq40patusJBGPZ4e9n1B73BbBXKTSNxJPd0BNCn+JpB5coH2kHjS4jIhmSNOj/gc1h
 xaX7yJPPRYGmKGmfyVTs5GDw/ttXOefbB9vHuW2Ifbyac2JuvGrdXB5//YIwSmYghB2QBuddb0a
 m0I/bLcyu8VtokI0hyFy4SfssVKrv8JrxeVBZPM2katdH+759CjA5yShWqSHOHb+IRg+FPVNiDG
 zYiRdHMLu6GINtNcXyQASmha6frbGi6f08hv0WKXHCu5s5NpECEMYr2/xlmoB/yObVRqLpumiL/
 a24g/3Ppn1NcjqYN4VNHadCMGRsl+1vGFLidRHC4Qdidpj06LdMi1+Tn8negZK3WPFSpRLpifti
 7sdXBX9MQWzUVwGkT7WV3/ncgFts1wbHdk6c0XsaqkMIXqtXo15yybzvzs/xYLSzgr0CfR7DRKD
 C1FF4+DY6arxsldldATxXwVOCJ2Rxmeq2lVhq1ZCsquhjd4=
X-Received: by 2002:a17:906:1b45:b0:c4c:f85f:aa2b with SMTP id
 a640c23a62f3a-c513a817fc7mr683872266b.24.1795440712569; 
 Mon, 23 Nov 2026 05:31:52 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:c1b0:1199:e313:6fb5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513aea8063sm412055766b.45.2026.11.23.05.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:31:52 -0800 (PST)
Date: Mon, 23 Nov 2026 14:31:46 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH] mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
Message-ID: <awRAQoPoRP6gAm9E@linaro.org>
References: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
 <awCou-Ra_Rldo9N5@linaro.org>
 <CAPzfCAZik7_3hBzyMuZ76JG2WjOGTaaRLSec21HLYHWEDk_TEA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPzfCAZik7_3hBzyMuZ76JG2WjOGTaaRLSec21HLYHWEDk_TEA@mail.gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 09:47:32AM +0100, Igor Opaniuk wrote:
> On Fri, Nov 20, 2026 at 9:08 PM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
> >
> > On Fri, Oct 30, 2026 at 02:57:00PM +0100, Igor Opaniuk wrote:
> > > SDHCI_QUIRK_WAIT_SEND_CMD makes sdhci_send_command() sleep for 1 ms
> > > after every command. msm_sdhci has set it since the driver was added
> > > for APQ8016, back when it only did PIO; the commit gives no reason for
> > > it, and the Linux sdhci-msm driver has no such delay.
> > >
> > > The delay is invisible for large reads but dominates small ones. A
> > > multi-block read is CMD18 followed by CMD12, so every read pays 2 ms
> > > on top of the transfer. With the eMMC in HS400 a 128 KiB read takes
> > > about 0.4 ms, so USB mass storage, which reads in 128 KiB (FSG_BUFLEN)
> > > chunks, spent most of its time in udelay(). On the Arduino UNO Q,
> > > reading 1 GiB from "ums 0 mmc 0" on a USB 3 host
> > > (dd if=/dev/sdX of=/dev/null bs=4M count=256):
> > >
> > >                      host throughput   time in eMMC reads (10.6k reads)
> > >   with the quirk     46 MB/s           26.8 s (~2.5 ms per read)
> > >   without            201 MB/s           4.5 s (~0.4 ms per read)
> > >
> > > A single 128 MiB "mmc read" runs at 255.6 MiB/s either way.
> > >
> > > Drop the quirk and keep SDHCI_QUIRK_BROKEN_R1B.
> > >
> > > Tested on the Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, ADMA):
> > > - on main (eMMC in DDR52): 128 MiB "mmc read" at 75 MiB/s as before,
> > >   the CRC32 of the first 128 MiB read in U-Boot matches the one Linux
> > >   computes from the same blocks, and Linux boots from the eMMC;
> > > - with the "qcom: Enable HS200/HS400 eMMC modes" series and the
> > >   mass_storage SuperSpeed descriptor patch applied (eMMC in HS400):
> > >   the ums numbers above, same CRC32 check and Linux boot.
> > > Not tested on v4 controllers or on the boards that use the driver in
> > > PIO mode (qcom_dragonboard410c, qcom_dragonboard820c, hmibsc).
> > >
> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > > ---
> > > Drop the 1 ms delay msm_sdhci adds after every SD command. It costs
> > > 2 ms per multi-block read, which capped ums on an Arduino UNO Q at
> > > 46 MB/s; without it the same read runs at 201 MB/s.
> > >
> > > Testing on APQ8016/APQ8096 (PIO mode) would be welcome.
> >
> > Please Cc the board maintainers (me, for DB410c/APQ8016) if you are
> > looking for feedback for these boards. I found this patch on the mailing
> > list only by coincidence.
> 
> Sorry about that (I relied too much on get_maintaners script),
> and thanks a lot for testing on three boards anyway. v2 has you and
> the other board maintainers on Cc.
> 
> >
> > The fact that APQ8016/APQ8096 use PIO instead of ADMA is a relic from
> > before ADMA support was introduced. ADMA works just fine in my tests on
> > these boards and makes no difference for the following test results.
> >
> > This patch works for the eMMC, but it seems to break SD card detection
> > on all QC boards I tested.
> >
> > DB410c (APQ8016):
> >  - eMMC: works
> >  - SD: broken, CMD55 response CRC error
> >
> > DB820c (APQ8096):
> >  - eMMC: N/A
> >  - SD: broken, CMD55 response CRC error
> >
> > RB3Gen2 (QCS6490):
> >  - eMMC: N/A
> >  - SD: broken, CMD55 response CRC error
> >
> > The symptom is that the SD card is simply silently not detected at all,
> > I added some more logging to find the CMD55 response CRC error. AFAICT
> > (without investigating in detail), the following happens:
> >
> >  1. In drivers/mmc/mmc.c sd_send_op_cond() U-Boot sends MMC_CMD_APP_CMD
> >     (CMD55), followed by SD_CMD_APP_SEND_OP_COND (ACMD41).
> >  2. The first CMD55 and ACMD41 succeed, cmd.response[0] is 0x00ff8000
> >     so BIT(31) (OCR_BUSY) isn't set yet so it polls again with the same
> >     commands after 1ms.
> >  3. The second CMD55 fails immediately (too early to come from the SD
> >     card with a CRC error).
> >
> > The CRC error seems to origin from the previous ACMD41. With
> > SDHCI_QUIRK_WAIT_SEND_CMD we wait long enough after sending the previous
> > command to clear the CRC error before the next command sees it.
> >
> > There different options to fix this:
> >  - A retry of CMD55 in case of an error seems to work.
> >  - Maybe we could check and clear unhandled errors in
> >    sdhci_send_command() before sending another command.
> >
> > This extra diff that implements a retry works for example:
> >
> > --- a/drivers/mmc/mmc.c
> > +++ b/drivers/mmc/mmc.c
> > @@ -674,7 +674,8 @@
> >                 cmd.resp_type = MMC_RSP_R1;
> >                 cmd.cmdarg = 0;
> >
> > -               err = mmc_send_cmd(mmc, &cmd, NULL);
> > +               err = mmc_send_cmd_quirks(mmc, &cmd, NULL,
> > +                                         MMC_QUIRK_RETRY_APP_CMD, 3);
> >
> >                 if (err)
> >                         return err;
> >
> > The real question though is why we are reliably getting this CRC error.
> > It might be worth to investigate that further. I would expect you can
> > reproduce this on any QC board with a SD card if you want to test this
> > further.
> 
> I looked into it. The UNO Q has no SD slot, but the same thing happens
> on its eMMC, only hidden -  on every mmc rescan the first CMD2 after
> the last CMD1 fails on the first status read with INT_STATUS
> 0x00028000 and then passes on the MMC_QUIRK_RETRY_SEND_CID retry. So
> the common factor is a CRC-checked command that follows an R3 response
> (CMD1 here, ACMD41 in your case).
> 
> With a status trace in sdhci_send_command() (card clock 188 kHz):
> 
> 1. INT_STATUS reads 0 right before the failing command, even 10 ms after
>   the R3 response, so clearing unhandled errors before the next command
>   would not see anything;
> 2. Waiting before that command does not help (50 us to 10 ms, all fail);
> 3. Delaying the final status clear of the R3 command itself does: 8 us
>   still fails 6/6, 12 us and more pass 6/6.
> 
> So the R3 response seems to leave a latent CRC error that only a status
> clear a few SD clock cycles after completion removes, and the clear
> done right at completion comes too early. That is what
> SDHCI_QUIRK_WAIT_SEND_CMD was hiding with its 1 ms.
> 
> In v2 I'll add a patch that waits 16 SD clock periods before the final status
> clear when the response carries no CRC (CMD1 and ACMD41 only). With it
> the CMD2 passes 50/50 here and is sent only once.
> 
> Unfortuantely I cannot test the SD case now. Could you try v2 on one of your
> boards? It does not include your CMD55 retry you shared, and if the delay
> does not cover SD, I will add the retry you mentioned in v3.
> 

Thanks, I replied directly to v2 (works fine for eMMC/SD on DB410c).

> >
> > SDHCI_QUIRK_BROKEN_R1B on the other hand made no difference in my
> > testing, I think we could drop that one (Linux does not seem to do this
> > either).
> 
> I would do that as a separate patch if you don't mind once I have run an erase
> test here, since R1b commands then wait for the data-end interrupt.

FWIW, I did a couple of erase tests on DB410c and the data-end interrupt
was triggered just fine in all cases.

Thanks,
Stephan
