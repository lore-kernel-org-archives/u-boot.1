Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747B3CC6B16
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8D166077B;
	Tue, 13 Oct 2026 15:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qiafVdTUacuC; Tue, 13 Oct 2026 15:05:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11FF76077F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903943;
	b=VqCHM6t9fK61vTbaJDwcTMrNQt2gZUqvCDJtB56EvlH9IEi8UEwMAEEDVErZhFQFabm1
	 J/rZiQWWW+PJo02wRbDSXmyHd+Pi0EPseIaCzHEADoLGeoR7xc7EQPX4aPwQ8zywjhmF1
	 iFBD3mHm8esU0YttF3JxEX6AP/1qIh1FkA97aWWOCAThhLQfy3Aw8brAJek6lRveSdh/K
	 rSXD2LrqBP7FX89VtXvgZhs4WqA8FMVaSeb7Z1W66V47zJpkfFhUsupUKM8Hji4POfcoV
	 DW9wFA7cL2LltolWTNEuy8iREgYi0dGKfrJQgvYwpRwlwZGytXsZCMLpbpXdP3ShEBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791903943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TYVTUBtD51mmp+5XtLkhLT1dqCy4Cwvx0z37wt893yw=;
	b=JndhKsVuz8FSOAM75qzZCYgYDFK2tfYl33WTTxNyjVL7oFkFzKcAF3JB4uGkLdJAMfXf
	 Qcqj9XCCwh32qxDxgZeXgQ0/gTK9uc1H3RWxanhxeVu3w+mSzAvaIf1LtSPJBCYyCqg/n
	 AWIQ3eIG1l9SH08qSqbSNVOxJ/k/VK0dBpjXZGjY3Y7o+hyOhz+eQfqAjuIZvHnBfPUPa
	 d7p+DvCCfRHwVHQpHTGvuz95ym0k9rmtCs1k7c3cb7/JZjWtOcOwe7Uy+CN7/f24PMz09
	 Ka8tfHRlBm4W4sHgJvCQKCw0mzwFWnNzEkDfAg5GLV5YI8DR45cNgzv+3i5pBeFB1RA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kMertpmQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791903943;
	bh=TYVTUBtD51mmp+5XtLkhLT1dqCy4Cwvx0z37wt893yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i7mrNXG7Ripi4ip0/3fq6a3NLam3Hkl/I4sFnHWH12XuJIvtTdf//t4HC/0o0Qv3c
	 ORgnYScOvolhgeZqyyjcfPb5Cw8otp4/yPnRm7G43dzKoVDIe5ZM6QlelSoCxoBSrh
	 tNfQ4GnQezWMGP2R01oABpROGmbEt+F+bkAwwGXRXdUKhaYK3+8GKU3UpMO7wNyuFj
	 Q5x9/wf6hrgDALIoZiltD1h/BERhhla5hZophxjGi24E+2TcB7C9z1HjMc+HDYrnyw
	 Gxeiq16kBLWPNmzNLeodAZlapKDnOBcFP7lBf2fhd2pc/aZYUACcW1OfBeM9u2kzIR
	 z9eHB3JrgRHBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11FF76077F;
	Tue, 13 Oct 2026 15:05:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AEB5F75
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 953E46077B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8oILrXnc3zd for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D68EA605D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903941;
 b=D5npzyIpAyv3r22CqjkSEYIPhacsxjf2GkhG0NwKpO+TnLjzdteRWsJL6OGtaieIxi+e
 PZQvZIMPl8h2jQjMqymnNYJlbawDnvEv3uK2C2aiBXRTX+JRvgKB+t2X1bdKz+ZtSGAzF
 4ghZpoUMeSSZSi00C8BF+ZQdRZ4tYCH9OwDRESWSwTVBQoUAXpqyJyq7sFgAt7SK2I9LQ
 5H8J9XX6PUk1q5BL1nqukwZfxq5RMEEbv8S4tbi6f/3HQDa4ZMXK478g7nKBDaItwQlPN
 bUgS2iQXqa3xoFqG4R5V7094pPjQeOS9mZMAFiRLfgnpBZlTNZRFr0HUpbERDuiHAAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791903941;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=TYVTUBtD51mmp+5XtLkhLT1dqCy4Cwvx0z37wt893yw=;
 b=SDUZ36hWcyF8ZQfuiTsoXKCddKDCIds7ezVFJIxQPL7BvHrl7EMD/2JljccOMtlktEqy
 RAtSuvh03Q2BonfD4zRocIpKQGF0rRZ3ig4N/xjEaiyesfc4iLHSEVHdMmeIgyXqtgh5P
 DLkj3N75OnvpWIG/TKxxTGh65THusGSoyPLestVBkJNPecev0BG5hYC9+qAiUFYDKEwlO
 MGMnQ2FfKwgCDOS4BTLJWg9bYInd81fIrV0M58dP+4TFENnNNFQskEt6JyfhjC6Yau7vK
 onvbpt5zxvhSgtBMFLN+rKvlnusxW2fAo33I4CTtBbh4HD/UFn5ogzC7DM5te1A0QsA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kMertpmQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kMertpmQ
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D68EA605D7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:40 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0af2aae63so13738077b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791903939; cv=none;
 d=google.com; s=arc-20260327;
 b=IRoEeBwx7FVO8VIdPlThwpjyFCRfp2sy3G0R+4IeLyAoKVCRc+HUucdbAQrbWFZ5Bp
 VHeo3z2r2pCtuhH1wXwaGHwhLdIXrk0VQIRS69++3uHWtapXNxP/P4ShDXwTIy74jfkj
 KCCL4FXWDTfmwPP6l4weGa7lQxLjISqDtd1HVuTrT6hSdWd1HbW8/wyudthRc1yVNeeN
 p86j/SqWuvAXDpsUSykBqpejX9KnaatWHkaTK4acv2jUa2GydD47s1pcxNA47tR43YE1
 a6KOHCWkkDGYIiCNejn8B77LGwZNcyCY9WRQsQWaKUSGpCTfcA+O8aPaot+6NcMx89pf
 t3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TYVTUBtD51mmp+5XtLkhLT1dqCy4Cwvx0z37wt893yw=;
 fh=D3dxf6vueivlRmlamE09Ax0YJslZZ1UEssNcKiV39Mc=;
 b=pXUFpVcFiCo/X1D/4QluPJTZJu1c0b+4G+8KGObRrcVGTrzXkc51DObI70ddWWX0lT
 eTiWtwWRedyhT/d6CQMWCUmAE8Juv01QwEecVF8dW0SAXb8GQdTRYN88Ow7ZGDaPrdJP
 u0xyPLRBwsoA0QxMDgl9VPT8yyY/6SN11fWHGnzaE32aMFd+FSmUGICHRxW8WT7ChrOt
 h/H6ikmnFv2vsCGh5ShmlM4fM6pIyrT47Yt1vsjPIY/7vT/YBcDg18yGOeCFoHyihaVp
 NAF8vw2uDxSQrvcNKssRWJnxzY3TB9mfJINKrMb0wmheudRpeK+UoDj3BW8VUVHiZVaf
 183Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791903939; x=1792508739;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TYVTUBtD51mmp+5XtLkhLT1dqCy4Cwvx0z37wt893yw=;
 b=kMertpmQZ5Jsg5IlsNU/KkA/N0UmVUNDEd2Ta1MP/hYXGJgsosLEc/cvvXb6PKT6SK
 gHF754w2uE4Cg4GxjVe96XJ9MIG/P1Cf6FfNZEfHZNjX6C5To5NxQG/OO5Q6LAMRz3+I
 zWoKrQNu2HSOg19c/h0LubY7iQAkE41s8Ct0aqeS3IP9eXVOwe6vVvxlnALjOIfeiplk
 F9r9eOMpneAoNq4GXtDCCcwADW4Di7ScnAws+isg/YoThmUzZ6mp+8hu0aRrr6qokz+Y
 kON6+9eeJMtpx7wEugt5UdQOuPUGHG2orXpyUFZkQ8WnCui/eSwvMfxl/aRV18WNRccd
 WH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791903939; x=1792508739;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TYVTUBtD51mmp+5XtLkhLT1dqCy4Cwvx0z37wt893yw=;
 b=Cg5VxEh3z21zeE7fZyiZu9Kr8LC0drgFa1WCJhhxLHe45Qb4tO7qxsJ76Uqn3o6Pa5
 mXzn2a11+Cp8Bt3ZS4tzGttMAnuK6mZATUAFjT0Azt4owuJo1alCNLP0/d71M7MmnJBa
 5YOuBxXVh9SJPcerHDO4pdnTvYoXlizB5Y1Ru9HiCwNhExE3b5gdzJErOaTM1FgOlC7m
 epLPiuUx/kYxP+B6+eaEmE6IgxIet3Q1VPzXeLAmdnmgdoIuZiTY3Nxn2sNAiINbvQHd
 iwkW344/RYixo7XXxjnH1TnZuQtOOCROuG19aaVtV85Fw9GhI5RXEnkV+RdjrocnH/IF
 bTDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4HiJrj9JC1qHbCEzuOapTBrT6MbIhheqWe5fR76NA0HY7TJvQ9FvSssKcLjaejZebTSnCFIY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYImR280eseiVjTEo6TQ27gbt2dVKGr24OixBQXLMaPv7orRUM9Y
 WF3UXNr+P+CAUZHzlVF9YXKRVC1aZFWNBq5XZwHudUHCIF+6ytT/Sde/Iz/CdipNM4uqnSzU34W
 3HJA40kn4dISy1OLyzwXNbICPDCY6xnQ=
X-Gm-Gg: AYBFou1ly3qqoIdUkHB1lSWmE6qJaljlK4ozLuo1gk4deAioZZddssMxLOy5bT6ndCD
 rtkAZGzLA6hoO48o5hQu4fuNZWzd+9XjEyI0bTYL9Dz9LL17PwBBfJKkJIWCgeLqKlpkQExrmYj
 274ANsBzyMZel8FDSNfQ13rW4IDb/d9Hv1xdowpiIszd7VDndTTv3+D+ALMsQgplh3Jxn7IP8e5
 d6PgH/JuSZXPniyA8lK7aTDLzTOEo0kWLoGyL2Tdr3VgZdQ+qgPcDeSK8aCLQCLDHugjRkJXRvw
 9RJ9RkhPF5GHNpsnVfGNC3/I+AyL9EHDPho6Hex4VaOj7qeHP9joWS92guGkJ1/VK0U=
X-Received: by 2002:a05:690c:e156:20b0:8a8:7e5a:dc2f with SMTP id
 00721157ae682-8b07edb723emr33221237b3.12.1791903939341; Tue, 13 Oct 2026
 08:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
 <as0Fuwvqy25b7uOF@kehys.lan>
In-Reply-To: <as0Fuwvqy25b7uOF@kehys.lan>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 13 Oct 2026 11:05:27 -0400
X-Gm-Features: AclHuK9mtgmgJ6MhKyR_SsLX2uf80q90dfHLRq8rUdJq3Q_LfLjP28805mazpYM
Message-ID: <CAMDkj5xmi0EEBgLjtM6UkyH12zo5Qh2qHY8qPKeL6AHWgbmt-Q@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] add software ecdsa support
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 jonny.green@keytechinc.com, 
 trini@konsulko.com, simon.glass@canonical.com, 
 u-boot@lists.u-boot-project.org
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

Hi Marko and Philippe,

On Mon, Oct 12, 2026 at 12:07=E2=80=AFPM Marko M=C3=A4kel=C3=A4 <marko.make=
la@iki.fi> wrote:
>
> Hi Tom, Raymond, all,
>
> Fri, Sep 04, 2026 at 10:37:04AM +0200, Philippe Reynes wrote:
> >This series adds the support of ecdsa with software
> >using mbedtls. So boards without ecdsa hardware may
> >also use signature with ecdsa.
>
> As far as I understand, each commit in the patch series v9 was reviewed
> by Raymond, in the same week when this series v10 was posted. Only some
> some minor formatting issue was addressed.
>
> I wonder when we can expect this patch series to be applied to U-boot.
>

On it. I will send a git pull soon when no errors are found in CI.

Thanks and regards,
Raymond


> With best regards,
>
>         Marko M=C3=A4kel=C3=A4
