Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD393606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kc0ZMvtI;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MWgzVlt2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A486040623;
	Mon, 26 Oct 2026 12:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H8pFFXxWAO_B; Mon, 26 Oct 2026 12:37:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00B1D40653
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018247;
	b=on7/L/y1LuLq92N23VhWfpz+vPIbk+wwqz+y1dR1AtjzMeaN0nFeW9ZGH0KrnzdHHQyA
	 zNRkC5+q0lwX0phpZX6cSspwMgmepp8M0+UX+e7POlIjrpBMxrdppzSCVF2aITvwhEJzc
	 nWtcKQucjMtOBo23re7Ygbkv5F6dsMVY7znQAqhLxQ0v8g96wHWYt+5AJmT7wd/F9iG/I
	 T23mRPCfZup6f3HwWiq1MIdPi+Jwv5H6BYKsfeuPOEfMhxpBV58euhju/Gi6Lb2PocpmO
	 jeLAG+Uppq7LppBB7qk7UtOOGg2gG7vJP20NqTwGJS01hLSBNfZpAg5c6xaqd5s9Vcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793018247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lR+RwnRgmhXw+fUb8MAA6Y6i6VFzJL7VrSfkiYewl7Y=;
	b=PIgHEFtgd56qgwnhw2KdC1FG8zihdn75kcY7DYy2HCahQonHebGVsky1jLH2QlnNVtea
	 sA+++l8cmESUmh/8Al9TCqIrwvYHatokamcXTfOpX1CmoP3nyc2GXW07s6PgWuMqQN/+y
	 M0GiVXxXWgUA2w8PZ7Phk7SWLELjux86NgFXkTL6txZWIi50C+eNZsDPFliH5N8yPteJX
	 fKDteOEkdVimtH3faaytJVyswc560251epmAM6cbnumJM1rknDXec4vM0mW9FeVAnzeRW
	 +4GUSRGEsetbTu8paqCKf1b+R7u+Sbh0C/CPnP+rqvLAPgNGIFPvPO3KUMdpMXIJ9iw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MWgzVlt2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793018247;
	bh=lR+RwnRgmhXw+fUb8MAA6Y6i6VFzJL7VrSfkiYewl7Y=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kc0ZMvtIZgMujegC3MZtmcKw66bGgO0aLNZCT6BsAWWuZIHjr4K2FZKsHFSVBfSPU
	 VybXuBST2XFIvwQOtc9dUnzI6+t59YhGw7JZU0C5U+clrpDH1A2wS+UzfVKwHhrQvF
	 08VoexG7VsFMi8I6xfHmMaxBBHayDcUetPoj1dsT2ajXbOPNJ521x7gATMQGxx1pZc
	 naqXQiSEV0FyDKvH0fKt3+cNFKEWp1lGY8T5rrwlPTnsQJARbXB5dz1Cax5nOUro45
	 zK6c+o4oHXqNVARx+w/nWo5VKon29dG36lt3VxOy4YYbiL6O+y/L9+ZNxBoMUpAG2q
	 d1IyvsA+kWNuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B1D40653;
	Mon, 26 Oct 2026 12:37:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 668B043
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CAD240623
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0HMMFdGwFSo for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99026405F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018244;
 b=e45iTkxe1/7IDyY4ZyV/FIXXqlwzOkMo30h5nvbKoiasZr6A8aJTnuQCAUGjFyFAus06
 jHTGjxAK0QU3EYvQ1/ktBvoMvNqZa1iiMj9b77Qw02VS2oGV2vRaGTTzTEhSJ/jHkDcR8
 DvNfq5fHz1ZHYjUlXSynqYOG1E/NoZgtAqV3N4pUp+2OAtjrh+1ZcN+a38tEhWSM4pcnY
 MjeQhKfOu+yfwwFV/djTrtA/wnLJfydEWzU8z/lXHctiVbeky00itkjnlTEGprlOHd82u
 5XNW++2/U/BxrdhcaLcrZOsehYggJUoba3vSSel5PB0gxw8Uvag9BlLSxc1kGW/L93g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793018244;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=lR+RwnRgmhXw+fUb8MAA6Y6i6VFzJL7VrSfkiYewl7Y=;
 b=hEAmfBmuDFwMAJtJ6DAj9vDcEZgWV0ZVL2Wl4+lsKC0gOvTENlesQBVXe7jFe8bL3b6I
 ZrUomCIM3MrjYntA37B9P3BEKnQDps1by5o0h+o684oeeLttjMDlEkWnpaS/avB6sDl4q
 HPflancwd4/A26h0i3yj/Kg//strCJ1l85OWLPaC8+yEU8qCWFvnTBZ7Om/ZpJKPw6pLT
 t7CJvVw3SlueRilR/I5Q9exPZWCBelxJC+Q+7TCmUenSMsOP1qWzSKhUk1vfkI0aEm+Xj
 iqo5cx/wg9rMat39TSza2kxIe0r88dYYs7G/EzJ9wL6q9zgy/tYRc2haBV5SwFz5qpg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MWgzVlt2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MWgzVlt2
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99026405F9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:24 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3adf5f6833cso954656a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018244; cv=none;
 d=google.com; s=arc-20260327;
 b=T8iJrJUrYP8+w7+zWT6ou/F2q2l2HT1x2V+UbFhsGjAPiQePDMRSkjgPRiAfOEu4nZ
 tIAEcSAntmYLlDFSGdUOry4y/FkqFRIB1YlJz3GhqIQiCOXJSj37Wa+5SUqI3JTeoDF7
 o5HPYTD4Gb2hJJVZ3KyWn9ihZkzJi2AamLEeWaq4X1InejC8frXR1cbDyxVAAUof+9vl
 i26c0Rf+xbVyw2pNKh+4IJohmW8tmQ3obdXjWoLO5TIBKU33km8Mba0+qwUSmwrRrpyV
 dMZX35t12E32vfJg4oDnJuVymcFwPk6472gsSzkiSy7vkcuX1lF2DouH0VMFYBWRdD61
 wOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=lR+RwnRgmhXw+fUb8MAA6Y6i6VFzJL7VrSfkiYewl7Y=;
 fh=Z7aW+HdLgyPZ0jGj/0NjUSORRexfTWDCV4R5Yx5lFVA=;
 b=mJxcRzjIndCVgQca6EmfyBR5annr83wCUUA1nBILB374e5pDEicgDL8joVoM2kqGR0
 fTU2spkY1mQIenCrwc/sNOvHhZ0PUrpCzCrSFxYADYLFbMJdfxx0rAZ9zsE85oWplvJh
 yPu+djm0334HOXpgZwLszZ4Z8uVUudjPe/sOqXpA0CkKgrCD9zHy/M/sNFJ5c74mkfI0
 6y0Sgd2u9qGCcE8aAjpswehJzCB6mXcsIgsTss1bRj2cRqLRgy/z1lPwPZjD2jPzlHEF
 v4OegHkTjlZdqtQkVD78p9EHKXdkyECupDAQUoS51KWtZM8HBq8NiyLu8AXobdiB2b8W
 D0Rw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793018244; x=1793623044;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lR+RwnRgmhXw+fUb8MAA6Y6i6VFzJL7VrSfkiYewl7Y=;
 b=MWgzVlt288YPpalcLwPKNFa6dbxa1jvwL+vtiid6Eza9KSalFeaQccZbFEdGovw3Co
 pLrENyqd3ZpnGan6ndAl6CFtzQI4/VQosTIX8cF6vo4BmMN/vl3F4Cydwm0S0DaYh8wr
 I3Ob9uvMpogBwKLEXnQMCV+7eUaM0MdmQclBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793018244; x=1793623044;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lR+RwnRgmhXw+fUb8MAA6Y6i6VFzJL7VrSfkiYewl7Y=;
 b=qZs6xWFuYJlSS/Hey4NjqKUet3gJObydSgyt9MgWqixh6tqOKUU6+DjPPSTopzKFM/
 WIdS7Ecyt/iyqzVHu3ujUpgtzU9GJ/q2qbACetwT5XBTFC9xirWkQO8hedxINVjV1bbL
 4fVISoYdQjgGQn0awr7zlLsGbOowq7WT8BnGCD9KbGYWXCzdW9NhKF+TnvL9HHi54MAL
 2g6zeYl4AL8gT+O5WKF0gCNfEVuVDlkplUnFrJ8lqI2vXEcIJ5/HhhymCLzF7GcJl2MI
 Vn/P7vJCS8YkzqcKaMV2BOuAe7oF+SKFa+15L0Vh9Lk9C+l9odjvL8BciWwpn/lU4Vqt
 Hhsw==
X-Forwarded-Encrypted: i=1;
 AKwUvByaPCnTr8pRHgUVSDg1ENqSz70D5A4CRlCtmPxW0gZ0DtnA4VPsg52ydZpN1b3B0utqMOf5cMw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNMCQfe8K+og8vsUWRMIHX9Z5lUdRqsn2TfWmXTSlC2AG2U8Oj
 i3YmEhhsNJw5P+jZTwWO/Dq8+jjewAYT8gWDMmmY+bMemHeA/hOSwhod7zbyAw3t+juR1M+U0yo
 HkDHKRCIDqPufLRoeVvQUTTmJ2I909Y1KQ27yAF8n
X-Gm-Gg: AYBFou0tLuEfi8Tlzembnad6PWBOfm9ojxeYoMNDw3SWtr94+xSIn9BEYs3rCVOqoUF
 QQrN2dQTWeocye7qIsHVbgPu1E2JSNdOq3YjcEVqSdlS9mQA5IvkD/+fl2jehQI36SD/nVvzz7x
 BHrZR3ix1rATiMZvx95MFuQAMZbiVqXhdcmnI58LqOwlXhn+Qm7Ca7ORaK0oOOOv/VzZ0f6sSEs
 rZRzju0IVoDSgv9bvJBhvp8gm+HF+78sI3/Gp4aP07ngf+XHVi8nEefVNUmH2oHNZGC+fjx9xQk
 uqnGKHFRA/thXHOPllGiQIXl/mOqEJOGV5BUFDH1mLEByPHGZTEb9Y6JMB8yXwEoSk/9QnjVpb/
 9zmtlp5STWcU74cO9q7IJAsCeVOi3iVBYbxc=
X-Received: by 2002:a17:90b:224a:b0:3a4:967c:6947 with SMTP id
 98e67ed59e1d1-3adeaae635emr5210034a91.21.1793018243745; Mon, 26 Oct 2026
 05:37:23 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 05:37:21 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 02:11:56 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023190034.911023-6-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
 <20261023190034.911023-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 05:37:20 -0700
X-Gm-Features: AclHuK8QwEEXyaTw_aAiL6AL2broyGxBFDMJlAZauQTZstK7FagTaZGI1nhQG4g
Message-ID: <CAFLszThCu2io42m1JcyNdTx1kOTxU_uCAma7MaQBKC7buVhJtQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/8] misc: fw_loader: implement request_firmware_size()
 OP
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-23T19:00:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement request_firmware_size() OP
>
> It might be useful to get the firmware size before reading it to allocate
> the correct size. This is needed for case where the firmware size change
> across different firmware version and is not always the same. In such case
> the only way to handle this scenario is to allocate a big-enough buffer to
> read the firmware.
>
> To better handle this, introduce the request_firmware_size() OP to get the
> firmware size before reading it. This way proper buffer can be allocated
> and dynamic firmware size can be better supported.
>
> FS loader is updated to handle the new .get_size() handler.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  drivers/misc/fw_loader/fs_loader.c        | 24 ++++++++++++++++++++++++
>  drivers/misc/fw_loader/fw_loader-uclass.c | 19 +++++++++++++++++++
>  drivers/misc/fw_loader/internal.h         |  7 +++++++
>  include/fw_loader.h                       |  9 +++++++++
>  4 files changed, 59 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
