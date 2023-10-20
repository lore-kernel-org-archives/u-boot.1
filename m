Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F005C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 12:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BA687618;
	Sat, 21 Oct 2023 14:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gdbpE/Z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40F586496; Sat, 21 Oct 2023 00:15:26 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9800B86C33
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 00:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so1213029b3a.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697840121; x=1698444921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QpIp8P+ALKsK0zCFPGuXrgZth13LkXaSdVqiixIvkhU=;
 b=gdbpE/Z0I//e+B11vD4yVcOQURWlfOMmVrGqiq/XHBMKigicxxokz3L8WPOAx+rL8i
 rp3MzloaryJibrxqo35Um1X0xcXVmttwjmYUDKY5yI434MBbdA6t3EdTN5B9f1+bGQPQ
 F4dtY20QavjGZinguk2+Vnj+x1z9pb/mI/qOCYwAEpkNd2mU8Ik2KmNUUOXj7L9R7rID
 bxRPAQM2JBUC9t27rfwmB6eQfGaAMsEJthjo4WiQkGGcjpZCFrZ4yoiXkTthWn/FlGrM
 hkojjSxfE7tYFG6Gm1opShA1AWoDFAdBWfDI4ZuOT30jaxeCBi2DZow7D3qnY2ajQzyd
 xQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697840121; x=1698444921;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QpIp8P+ALKsK0zCFPGuXrgZth13LkXaSdVqiixIvkhU=;
 b=kEeO0oQeBynUrKtFFqXsh6MJ8xSbasvR7MoXMxzHhnF/qHrfH55Ah0/1NGAwyAL/4I
 H+jaeYo3Cs3YCv8qtE2GCiBjGI0qe2EH0EgjtD5Zox4WWKOqJTSOgU1Cb96r/7JoIbGv
 BW5YuBlKCTHOavIh3OOS/P1UkYydAmNmIiY+L3wnUZ/Meje2yKy/DBDucCCq7MrUOZa5
 dOm3gNbYm3MyeJY7kIqd7G/bQuEyYY94tlXORfydBu60jSLRIPLGBb4Se9/1KvW9638n
 rdILCBFNlmXAx85IVIKvqZCTiZhRtrqccLA4wVP2tRRKbxwQYS4Zxj6639jyLsSEipn4
 OCiw==
X-Gm-Message-State: AOJu0YziXknnBpSX4cwMpJyi4iorLFpbDfDzQay93k/CT2j7dzK8yHle
 Zaclq4MNoEsBtJBpQ34CnoN7XewJVdf1JRund1LEoQ==
X-Google-Smtp-Source: AGHT+IHb9g3lCOJhv6XYyWLMfLsWFCuAMV7rL2qnCoS1QiEKa/l95YrHkP88y0QHFKYu77ail3bVTPEwZ1YbyDbzkkE=
X-Received: by 2002:a05:6a20:4393:b0:17b:4b61:a907 with SMTP id
 i19-20020a056a20439300b0017b4b61a907mr3691560pzl.50.1697840120765; Fri, 20
 Oct 2023 15:15:20 -0700 (PDT)
MIME-Version: 1.0
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 20 Oct 2023 18:15:09 -0400
Message-ID: <CAEfUkUJ31KTLc6mvGj741ZthSQdyXyS0r6cv2XUDycTq24yjRQ@mail.gmail.com>
Subject: Re: [PATCH v2 30/32] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>
X-Mailman-Approved-At: Sat, 21 Oct 2023 14:41:14 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Thu, 21 Sept 2023 at 04:58, Simon Glass <sjg@chromium.org> wrote:
>
> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>
> Tests for this will be added as part of the Universal Payload work.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - No changes as it still seems unclear what should be done
>
[...]
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 080cc46a1266..e16d122f4fb1 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -103,6 +103,11 @@ enum bloblist_tag_t {
>   BLOBLISTT_ACPI_TABLES = 0x104, /* ACPI tables for x86 */
>   BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
>   BLOBLISTT_VBOOT_CTX = 0x106, /* Chromium OS verified boot context */
> + /*
> + * Devicetree for use by firmware. On some platforms this is passed to
> + * the OS also
> + */
> + BLOBLISTT_CONTROL_FDT = 0x107,
Shall we re-define all the `BLOBLISTT_` tags according to the firmware
handoff
spec v0.9?
According to the latest discussion (in
https://github.com/FirmwareHandoff/firmware_handoff/pull/19)
It is preferred that generic ones to start from `0`, and Arm specific ones
starts
from `0x100`.
In this case, the FDT should be re-defined as `1` and other existing non-arm
ones (e.g. for x86 or Chromium OS) should have their placeholder before
`0xff_f000`,
while generic ones (e.g. for TPM) should be placed somewhere between `0`
and `0x100`.

[...]

Regards,
Raymond
