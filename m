Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4404C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 08:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F5B787B2D;
	Fri, 19 Jan 2024 09:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Opet+Ox7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939C887B43; Fri, 19 Jan 2024 09:47:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC4F87AD0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 09:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705654039; x=1706258839; i=xypron.glpk@gmx.de;
 bh=2O31wQZflmOMn62LKE1RcKDqsYinm7gWJMYh50sPRfI=;
 h=X-UI-Sender-Class:Date:Subject:References:To:Cc:From:
 In-Reply-To;
 b=Opet+Ox7LsaHLq+713HAZJRXDlPZLmGBDZRq2JNOu/cY/nnjFnbv03coG9D23iAe
 p23I+FO/FL6U+UVaQPPKwPTSbzEqce1LF4tAUVWUFLUrFkvsf7fs7R7ij4VMk4bNv
 CHwMHlWzEqYVu6TmRwZc9GzZUTSXJCgh0y/bqwo1Ghy+fq4p/1zFfSk2auEa51nI3
 kMo5446IXIXJ1BsxGqj9Aa/Eo3+PJnIdmOFh9VP4mwLKmIO9/I9XlHRUi8ezbTp4l
 veSsrPOQ6F99xTFUo262v8wvyjlgN0ZWYso1XfnoGh/4Ij4U7QMkZnj/uKyrYO0t2
 Ry0pi0boYU8HQ0hgmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1qsEWf116M-00b2UH; Fri, 19
 Jan 2024 09:47:19 +0100
Message-ID: <b74415c4-3be0-41aa-b6c7-eade599e2baf@gmx.de>
Date: Fri, 19 Jan 2024 09:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
References: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
Content-Language: en-US, de-DE
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
X-Forwarded-Message-Id: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6bEYmEEIN+wTkiQAP83XWPfQZvy7eW7JrrSnVENkxzwSJlQBL7s
 o/Zum9drA7UHX0jEvbZ57FRWEECtRkuDT6DkLDLa7EhaghFitnjXyqKODJLp3b9wN1PlHM1
 f4hFUdb9PEZSYgbrJGIoj5V6gPiLEa0T2J6qKgh8EOSP2elfrYbnbq3gISkJLj4b+8I/nh8
 JQ2Q0zxhQrhjaBzWDsCsA==
UI-OutboundReport: notjunk:1;M01:P0:8qqA/7q8CDw=;lX85Dg6RA66v8ejQzm29xcN+sg6
 mC9U6U6zl3ON8bYPkuEL863wlMiGdjuXFtzO/VFHVS2PJ5j5wxZSucQaSFInygpoWHn0aDjS5
 8tu/R5N3yfvQKvQYdC5KIMYMbFwBW3lPwX4UOnTAasQuIZabmISQuwuqWgthsb7uE8F4plbHc
 bACLvFrJCFd9bVEEO1f00HNhmWtPnGdG5VHbkCmT23hBpDgbCROsjbhI2uuRIcDkBOm2biyQ2
 5QNsUF3yvKEWzmXRWgV0iDln1bdIES207H9F/fq2qk+KriCL3YGp7ujY36/5bTOWFJgaTGWJp
 jbR0DUCoY95OqfHnSONffwE6qahV6f7lMiccsLqJczh2C3aCKg7cB59n+njvu9K7c0WfTY6kL
 EYCoDdeMrWa+mEIqL0NODG8inBbzoVS8U/dMAQZzMOBzkVMjYb7Qq5cp4hoCq8YZovvgeILyL
 7j6fYkLnZ4GWE0maUq9rIzOVlRKaJcgGcJagxnwTflsw56v41wbT3vD/ZOplp+5jHuaK39fBD
 X5YoCnNT2KhlhwiQh7bT627/VwojW1GQ2tIEg3+7viC8sW2DcaIBvwNjXB6R2jqDu0Pt5+0vb
 Y7pZFbJwiUX7rj9x3EEz7ZTpcQUjRxLSQa6dO07lMFcrlPoaedJNdD/aprjy2At4+3RetJj0d
 o3xtMxGfW2pWwxQDRUkMsCrpalLY5VitA5WLhcwqwHiM/40ZYPaL+qP46O2Jdur7ZuKh+47X+
 KEcGqKLXrQUI0RAdyXlJZ0yAgE5p9zt6MZZCdnFmlyl6eWQ7THnE5CKsMIb378Trve37/zGTe
 yusx3Rnwkhra8n+4jmfY1iNDVL5NVn2W42kBbqRLCyfdOyfr8pYW0Q4jqG8a6CYbJV9/gba90
 f/8bwFT/LL4TtHrc64zyyvsI9p8s2P+dEu63uepekXm8wfmLWnjkUkh5kTwpe2sFI1hNu5ryk
 gZYoMvd6KRr25CD8P3XNOCnbK1E=
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



__________________________________________________________________________=
______________________________
*** CID 478333:  Error handling issues  (CHECKED_RETURN)
/lib/efi_loader/efi_firmware.c: 413 in efi_firmware_set_fmp_state_var()
407     	/*
408     	 * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
409     	 * variable has not been set yet.
410     	 * Ignore the error here since the correct FmpState variable
411     	 * is set later.
412     	 */
>>>     CID 478333:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "efi_get_variable_int" without checking return value (as i=
s done elsewhere 29 out of 33 times).
413     	efi_get_variable_int(varname, image_type_id, NULL, &size,
var_state,
414     			     NULL);
415     416     	/*
417     	 * Only the fw_version is set here.
418     	 * lowest_supported_version in FmpState variable is ignored since

There are a lot of different return values that may occur when calling
efi_get_variable_int, e.g.

* EFI_BUFFER_TOO_SMALL
* EFI_DEVICE_ERROR

Should we overwrite the variable in these cases with NUL values except
for var_state[update_bank].fw_version?

Best regards

Heinrich
