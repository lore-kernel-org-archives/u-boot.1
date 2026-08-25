Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BE5C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84B1680C84;
	Tue, 25 Aug 2026 22:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZDHQBCcvNIc; Tue, 25 Aug 2026 22:20:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787696437;
	bh=TjBvUBDVMbInjI2itJMYDR4yx91aAe8Dzc+8DYP8VyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FEmlB/sLguikhy9t1cWAnuEledmXuVm45mqfav1Tw2AB2PrXYzlYn7HDr2hAaeyid
	 0QzDAFHH720tQRFzjVDoN6JrG7Swv2mkcWg5+m+uy9CFVQAI11HptzmFsAf8zQKAmO
	 Ug4b0quvdHU9AvQAAW7pRisA+EcsUn69MqkfMSms6UXUZMZhYXnfIy8dN/DxAzxEK0
	 uaELz5Z3bhzjQrth97yMb1KjXOQ9qrkuLmyaEDMxQRh/jXMdaSpHkiLJqX4GR7O+Nz
	 iZbjxqN8S8QysyBPQ2cxZILD2NRmzHdNos1fNnrrWp5XwV0Tk5hBqptsO0LAteJfZc
	 lttJPPtgfaSmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7442080C68;
	Tue, 25 Aug 2026 22:20:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AAF2A39E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CB4E4008D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V41U-LfWKzwE for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:20:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=DvJzArbI
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DD1D40055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787696430; x=1788301230; i=xypron.glpk@gmx.de;
 bh=TjBvUBDVMbInjI2itJMYDR4yx91aAe8Dzc+8DYP8VyQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DvJzArbIWX6e6wsKYYXdqCsaPX8JWqldRTLpDUKQuCkWtjGxoZXAVDMs0AHYdV05
 n+FqYx0+ikdL2TyVZtX/92AD11xHVirhMpZTfbE7L60ueh+ZCday1V/J2HRBStd7Y
 eYJNVNOyY9KPe/EPOPwchTQW2/NjZ8h4i0nwkDWkYJ1P+BGjCPZn13BFBZyodHwdF
 T0Kv+U2rOLqRwR2v7ykdfeJoipLSEq6Y/4SfNAFnGi4yKuH8hwW5VYnPsC+42pReG
 VEK3nAhQooTRL9siyezliRuKHqG1RT+SXrTzJ9ZmcH4L66t6eVZzW0rFVZuUAY7K2
 AMZ+2rxOfYbmv1utWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1wjn4X447s-00wznp; Wed, 26
 Aug 2026 00:20:30 +0200
Message-ID: <7d30967a-e33c-404e-9ec7-4bbab6dce415@gmx.de>
Date: Wed, 26 Aug 2026 00:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] test: boot: Check that efi_mgr boot failures are
 reported
To: Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Denis Mukhin <dmukhin@ford.com>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
References: <20260811155940.17698-1-aristo.chen@canonical.com>
 <20260811155940.17698-3-aristo.chen@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260811155940.17698-3-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wZYv8DmQVb3qzSdS8liIbBur17LYaRbqRojDP23rxLaWe9D5EY/
 3lDCbhb0lSvSzEms0mustSxLpUQuvCXHM59JsJsPsbuCJlYQoD1NqLn8LnnLJw/C8tji1ds
 f0T1M09+KbdgpHmsBWa5gApHQqetgjU6ge7hSSfWo7PG6jY0SckGOzzzHNui7SlrLP6TPiY
 n6vMMF7GuYsd84xmkd75g==
UI-OutboundReport: notjunk:1;M01:P0:hvhue/f2xUc=;KbqxDkKuXN3dDp2TtjhUxmrgs2/
 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
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

On 8/11/26 17:40, Aristo Chen via U-Boot wrote:
> Add a bootstd test for the error path of the efi_mgr bootmeth: point
> BootOrder at a load option that does not exist and check that booting
> the bootflow returns -EIO rather than the generic -EFAULT that
> bootflow_boot() reports when a boot() method returns zero.
>=20
> Running the real boot manager initialises the EFI subsystem in the
> sandbox process, which would leak into later tests, so restart U-Boot
> after this test in test_ut.py as is already done for other
> session-changing tests.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   test/boot/bootflow.c     | 35 +++++++++++++++++++++++++++++++++++
>   test/py/tests/test_ut.py |  3 ++-
>   2 files changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 1cc137c9700..2d80577921f 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -470,6 +470,41 @@ static int bootflow_system(struct unit_test_state *=
uts)
>   }
>   BOOTSTD_TEST(bootflow_system, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_FDT |
>   	     UTF_CONSOLE);
> +
> +/* Check that a failed 'efi_mgr' boot reports the boot manager's error =
*/
> +static int bootflow_efi_mgr_err(struct unit_test_state *uts)
> +{
> +	struct udevice *bootstd, *dev;
> +	struct bootflow *bflow;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_EFI_BOOTMGR) || !IS_ENABLED(CONFIG_CMD_EFIDEBUG=
))
> +		return -EAGAIN;
> +	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
> +	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_3efi_mgr),
> +				"efi_mgr", 0, ofnode_null(), &dev));
> +	ut_assertok(device_probe(dev));
> +	sandbox_set_fake_efi_mgr_dev(dev, true);
> +
> +	bootstd_clear_glob();
> +	ut_assertok(run_command("bootflow scan -H", 0));
> +
> +	/* Point BootOrder at a load option that does not exist */
> +	ut_assertok(run_command("efidebug boot order 00ff", 0));

It should not be possible to add non-existent boot-options to BootOrder.=
=20
We should fix this in the efidebug command.

Please, do not rely on this buggy behavior.

Best regards

Heinrich

> +
> +	for (ret =3D bootflow_first_glob(&bflow); !ret;
> +	     ret =3D bootflow_next_glob(&bflow)) {
> +		if (!strcmp("efi_mgr", bflow->method->name))
> +			break;
> +	}
> +	ut_assertok(ret);
> +
> +	/* The boot manager cannot load anything; its error must not be lost *=
/
> +	ut_asserteq(-EIO, bootflow_boot(bflow));
> +
> +	return 0;
> +}
> +BOOTSTD_TEST(bootflow_efi_mgr_err, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_F=
DT);
>   #endif
>  =20
>   /* Check disabling a bootmethod if it requests it */
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index fa50c8008a5..787020e3e0c 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -643,7 +643,8 @@ def ut_ubman_fixture(ubman, ut_subtest):
>  =20
>       yield ubman
>  =20
> -    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_sc=
an_boot"):
> +    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_sc=
an_boot",
> +                      "bootstd bootflow_efi_mgr_err"):
>           ubman.restart_uboot()
>  =20
>  =20

