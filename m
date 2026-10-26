Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CD606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=huaRljSs;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=N5W1zOom
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1AA2405F6;
	Mon, 26 Oct 2026 12:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QO32EhhkT0pZ; Mon, 26 Oct 2026 12:37:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 12155405F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018231;
	b=sFWI80Wnbe5tuCEZ3Ww3JHz4fi2y7qVQRC1+GiYIN7tONyTnJPXXzovnkOsLE7BEtOpj
	 mGZFvo7JvuB6cmIWoiQVPJaLg+nXWxBj5g35NyizgFlIF08Na7SuPDshbSE399oG9AAkF
	 PPBB0zYLC9LxGrKzf9SAgLq576nZGJnHC3Q8Z90TbAjM1yB+EGu3lA5gsJsLjQ0v7w9IY
	 IGJVFEVzJ3AhFp9taYfesZYVkWR5IW3JcQ3RJHTWq1YoEoEyQJjNw3LIzvuxu0ZuQModH
	 HeFCJFTHS/pUnnk74G5FlZmGO8guBZShzAvjgI6Y/ZmuGElswBtuJfsWIFP8Za/86Mg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793018231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iN4aJ4JOg3s09UHbgJ8Dpc8PaChOludAuNQ6IrTnptU=;
	b=Wg2Cl+nmlsneUt9asudvZCiS+h6mLZxujEeDtQEdwJvsdr0X57CUIXOwQVOS6fXcLyiD
	 2aZAy7ySRF81ZpWAE7riVyIN3JOeL/xOFPNkvoDtEQlf1WWKEhGGIWznTJmFS7zlAa/Qz
	 ftaLpBxuAv1H1AcKSGtMTV1W1HxWKMP8Dl/RmyTUtMYzHU6B3FW3k0mgeIxU2CwmAcaTi
	 EFzz9XOH3IR3gMQCq+855v8qIW0OaLUQfjr06z6+6esQEeJKjjOgC5RqmQ+PIFe+1qei3
	 O6nxY6/e//BB2K8lbYv4B3RQi3M/9+DN6HSJ9Zl6IUVm6FKcKEqFVB4IguZ6e9Qe2Yw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793018231;
	bh=iN4aJ4JOg3s09UHbgJ8Dpc8PaChOludAuNQ6IrTnptU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=huaRljSsIHhzg4fzegYi1FeX5hdMC3Fsrp2+VwPznUULmEEyZu0R8v42TBaiwovLv
	 AMGln3Ubxiqkgd79pE8NcF8dUKSwlTonPz6aDDO8F3MiSEIJJ/YmOmAuM05hR9fCBQ
	 6FCwQKoBsfXAwzMMoiB8CbpVEawBgpLsWnSZ+n3BSYRq8j/zjY8dBbFagD5vybjaDc
	 4/ocsSwxbLfv0RNFMNSo2MSQdcT6lx4YRGZhwik5wdX3NsqFH7xyVhD9n1fXKErkMn
	 v5UhegRIuoIR9l/dK4MbQpb0kqqybuJl2ajxjlrgMbhEBxxwJ/BnRT9EHNloD6a76M
	 sMJ02s9F70Gdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12155405F9;
	Mon, 26 Oct 2026 12:37:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F34ED356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0FAF605EA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YyBkW8qAkHnH for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:37:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EFFCD6060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018229;
 b=Quy0hcyHMUpDUY4LLfQePhYFsDRt7s1m2oafsy6Hmo7SKe9cgIgi5TpYDhO0Q13LrPUh
 BJeVtkymANffwQILxoZpRXnrgqlh1zLUWguK/xGK8tKo9vht7xOATKYTxyly1g39DJLRQ
 MssdCErBBq/UKV/UiB8WvnlraYT/nk54WWtpD8u47BeeL1k96A53CW8IW+idhZ1eTuzj/
 LlAP8Sjsx6VhbokLNw/s2LXD3H38mwcq99KISjlmduquZfJYBlYolmoE4DuGjvFFL/v9y
 vwu9saHrdpPWeok5LVwhMM0r+V0zSJzNZs8C5BGvJJgKSsOnjrz2cgcCvXX8salbIlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793018229;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=iN4aJ4JOg3s09UHbgJ8Dpc8PaChOludAuNQ6IrTnptU=;
 b=Nk5uBv6qsq55sOZ9XxnpYK9ASLnHf3ycpsXp5mAbaGdAsQbnkbeyEwJRCDE4DOMFjTfh
 SWxi0iy70NGPf3Z+YpXQlY2zSR5YW0l0BSx+P2k4fergA79odHP5vVwycLo+fG6Fr68uf
 GpKQ4pjm+xaH6Bz8613oSzvQ+4Y77ihjFlKuQdIHpq+KTjdQGmceRlKGVYRgBRyGaB04h
 P1U/m59GWhOkjuMqn7qO9Q4WraNGENZOav8h8U0BGW5aVT57H/Mk6KAubk8O5a1pOBENu
 odxOg1HXj0kJRW5A/o3pHQpu899p4hEHbXQtw6BgpAFUqtjKoAdtLiajLpo4AQbgtHQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=N5W1zOom; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=N5W1zOom
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFFCD6060D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:08 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso3832890a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018227; cv=none;
 d=google.com; s=arc-20260327;
 b=VDrpxf/xzXVycnRP2o8phhhK8uvOtZ7MU2hHp9uN/yqJ5JgBHsQtrEZAYEddeTqp1v
 jtttPJXHAiOAaHy2Swi+gknQOcugLu9Eyyd8mj8CjnuHxsRe+jW80X4rwdwk7gvh9BS1
 HqadOJjRCHT2MBzmCdayO4YRDlaL3HMdU+W6FwQ46/8GR7STLSaIkeQT3N9SgOV3WqLS
 r1hULz1G5YIDKJg3xTlaEh+qSNshMlEWJTBJwZpU2Gyy2vZKjSodDh+QWEx/G/MHt6+o
 o/N7RlmSK7gWuDBWv4VWgr3HKM2Knb1UNJ1vGBanePe882DbSaaSK3mb0KUBHWcD5Jmh
 HQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=iN4aJ4JOg3s09UHbgJ8Dpc8PaChOludAuNQ6IrTnptU=;
 fh=gDXRISKP99udO/S1E0sqRkbbGCbsENU8lND0qa8HuEY=;
 b=TacD2pXTPQlD9ELGsokjYzMz2dOLzMmC3wvmEs8b9rjBUj/NoFmjugYJQAnYfFnQmr
 XSVF/SofFAQnFLtRtKJNlggeh7gHE6YecCYqzJFZ3WTGrII09WptHI5Ep6pcsOv168cL
 e0BNzuHDa7IxtuPuVl+/jSHBrMhxZ7X1dDDtGrrnxoXDDrG3okIi8VAn1VcR2cvfSDQl
 kiKk3u73rZ2tIQBoJpJaAOckQ+lxlryHsO9ze4K/UonRwXo04WVGql/aVK/BgMSQpCGI
 PQo/6ldAOlhQGHEQWsoDYxoH9z5CaGH9/AR7AQzI4m8CXKaOM96+NPv6MuCZ7yOE6WId
 YenA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793018227; x=1793623027;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iN4aJ4JOg3s09UHbgJ8Dpc8PaChOludAuNQ6IrTnptU=;
 b=N5W1zOomfdaadSvSRQOYVcfrU71bJeg5BrhwFBjz6+jDlX1K/kM9pgVhufz3BAPqRX
 S7o+YEfDXgm+ky1Ss6GwkXIFLBkwT/7ScohYsAbmTe6C6Lw6lKIjy4GmBPhBnMOhQGaX
 sSNTHknj35VkvtV9k5I45ua5/5pTA9ygpcbpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793018227; x=1793623027;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iN4aJ4JOg3s09UHbgJ8Dpc8PaChOludAuNQ6IrTnptU=;
 b=fKyF+nDIc3ixK6iZVOdFyU6ilinHoIUbWXHml4urwzq/lEy8+lbBqEQ0RzEsYeEgpN
 RWYg4imp1I36STHhMqiBqPtQKvFrh9HyKI+jKsofobZU4iAq6bK8iWwacGZd0VMssMw+
 LaDHc6oz2EXGse2U1kP+GQujbgXXtVuenADcC3jmSuwjm1u9gdWfyRKnE4nMW43SMmVj
 JMa5aOrpvAhGKxr8YZKjRYE77FRQTq8rS6mP8mvfg88jYQ4Ds++00dlVIe/U/Q9hyh/Y
 WoiyUdnyvpAGWsNsLRMenPI/EtiaILeE/Azkziv5DIEjtmZhgCau0fyoH3euezKQ4Dy8
 3FVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6x0RPkTicgw1QIzBZb1V1AQ1tgDkjOG9O/yvjRnzC+Azh0hht/Awc1pRPtSnNHRQPrir5Vg0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ/JEhoQUi1LFUgaZ/mE5M74bGJmB/9fQaQaIkJo/2ovtsMALdO
 WqxwOru5XKqcIACxc0bG6hdIeFyVatZV5GQPOkRUT2YKvLObFDeEo+bfDSCRezwNNgms8J1Np/w
 g+peDppiFSyeY4kkJs+fKHJ71PBIV7XVA535T3P5g
X-Gm-Gg: AYBFou1b3/xQGjAreuWCtnjxpAKCV+qobOod/6YVBMNOWkohO0m3HNj5eqUViNsDj1p
 gIy5AftnGQj9W46HPMtPYNA4c06uZwyP4ERVx2YgJGUcKbK71JKVOzj61P/vFe8zarmwj8a2qSn
 7fh8E5VXQk/xDTcA7lW2qNy2q/khsrkn5IPo3DjVZPxiZsQG9mHXrsTe3t4gIXZKc/W8jXHYpoD
 amqUVW2m6W+U0OMzee5e4P16uQGDGgJvFCP1pUcAuPhYKrUUP9HMjf9kMU+thB+dinftEAlSgT4
 WmKCo3qUfhfpc+7vU4ymzuVM3UvcD+iPY/rY99Dl/418EOiVCQLH37NvUrFUMnbVzSQCidOwJq1
 gZShX2VVWk1Rb7cSsTknIvKSMwYa+0FeMyn0=
X-Received: by 2002:aa7:d903:0:b0:6b3:f891:c2d4 with SMTP id
 4fb4d7f45d1cf-6b443001749mr5863866a12.29.1793018226480; Mon, 26 Oct 2026
 05:37:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 05:37:04 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 12:36:03 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023190034.911023-5-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
 <20261023190034.911023-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 05:37:04 -0700
X-Gm-Features: AclHuK8CRLalyfIQ8MeZNskLEnBeDlqTXXEywFbzPMqXEZ1Hu3pBrAqN-oy9De4
Message-ID: <CAFLszTjpY55xVD8nSNZSweaMdBYcP8AnYvZxMxWGpj+tw6wfQA@mail.gmail.com>
Subject: Re: [PATCH v9 4/8] misc: fs_loader: validate requested offset on
 reading file
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-23T19:00:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fs_loader: validate requested offset on reading file
>
> Make sure we are not requesting an offset for the requesting file beyond
> the actual size of the actual file.

>
> If it's such the case, log and error and return -EINVAL.

Please can you mention that this patch also splits out
fw_get_filesystem_prepare(), fw_get_filesystem_release() and
__fw_get_filesystem_firmware_size(), since the next patch uses them?
Also, 'log and error' should be 'log an error', and 'the actual size
of the actual file' could just be 'the size of the file'.

>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  drivers/misc/fw_loader/fs_loader.c | 59 ++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 12 deletions(-)

> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> @@ -113,6 +105,51 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
> +	ret = __fw_get_filesystem_firmware_size(dev, upriv->name, &size);
> +	if (ret)
> +		goto out;
> +
> +	if (upriv->offset > size) {
> +		log_err("Invalid offset. Entry too small\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = fw_get_filesystem_prepare(dev);

I understand why prepare is called twice: fs_size() calls fs_close(),
so the block device has to be set again before fs_read(). For UBI,
though, this runs ubi_part() and cmd_ubifs_mount() twice but
fw_get_filesystem_release() only once. It still works, since
uboot_ubifs_mount() unmounts any existing mount first, but the volume
is mounted twice on every load. It would be better to mount once and
repeat just the fs_set_blk_dev() step, e.g. by splitting the mount out
of fw_get_filesystem_prepare(). What do you think?

Also, please can you print the offset and the file size in the error
message? 'Entry' sounds like FIP wording; for a filesystem it is a
file.

With those:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
