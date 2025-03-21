Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE01C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 11:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65036807D7;
	Fri, 21 Mar 2025 12:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mn1Bhyb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98EF4808A2; Fri, 21 Mar 2025 12:34:49 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BA7805C8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 12:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742556884; x=1743161684; i=xypron.glpk@gmx.de;
 bh=lrJ/ymAIfE2FcVYJ3XgyxeO4PBjlnHyM4aY69V9jrFs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mn1Bhyb7kbvQY8cPCamOyLpemlyD2ao6ve4ucQuZuLSOebJXFRP6prGnYsYI0vMY
 pQKTZ9n8QoFkRT61eMxpbkR53faFOBXFvrw0F7C4p5bxWTkBfE3pxt+9+BGA/AtrC
 6eKFSBPkrx+UPHZ4Y6HvvbwRZ+y10XJFYv7KJhwejKtmtK7+WsdO1bunJ3+Xz3Vtd
 dc58rxx7A5YXbG7g3zOkt8dxO94LGFcBYRm8f/cCaapMFiichP7UD/Z+uUBBb59SB
 YAiQXRh0snUHuchu65QvA/dDOV4L6j1cHR0b6eJjcirK4v2EhKNHkMTkLEW1uFvAe
 xQL7Qg9s22Xew9LhJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1tuDCg3qgX-00B4Yh; Fri, 21
 Mar 2025 12:34:43 +0100
Message-ID: <9e22e439-cd75-4046-b2b6-33b545f091dd@gmx.de>
Date: Fri, 21 Mar 2025 12:34:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 44/46] test: acpi: Correct memory leaks
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-45-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250315142643.2600605-45-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lVbMmBOz/2UJGlJ3RWQw9xpDSQ5MDPi3cJjKSAqBBY9nGMnL6py
 +psIXhD2BW/JCULgHCz0Xlr6OGEVpRu5nronMPOeRie61cFMKs9aNxhHaDoS0xl9hw7xcwe
 W24VWpJHRDLBfH/rC/DvruQj7UJWbWbO3tQHWCCWEfCkSnjMtIeT12Ij4KPT/1sDFH1dsDD
 d5nligCsELnffH7EdNkUg==
UI-OutboundReport: notjunk:1;M01:P0:FCAtpWXE+mQ=;mlPBgjc9Sv2guoNzTlfqWDkHjad
 hEja+UAVVkQZclCwYqmLgkUQrTHH6A/QkLALrLTakEbmAcie01znRsXjO/7KORX9jZJH/DfmZ
 wXu++fdbC2BD9qd61SDUKPVK1Th7q8NFPYXyVJ3ZBkFwf04XHLhfewfHwjBfWtXsa9lWMb1Wg
 C9Eg7b1mdE28L70rn+RLIBIdwuv+5pOvesemz9p4SQ0ZpUUaA7GRiQsgQ98TGi1O/dH3wmyQs
 n0qRGbEIHJm5XClNyCA4E75xidsqwn5DqNY82LoamnGqt0Ki8WDxPf5//EMWEeOKT5kC1pjqx
 TaJx6Q+ajeMOqTqoRaPraeq4SnbEwVxTj+N4z7XbnMHEjSCNzI0vbxONFqz+OYD2/9qFQ9BYL
 JWt6I7wmVPXzjcMIgrQjK9Ol6PTEi2AXJlQBvENSjoU3YCe5ncBAapUOD862VMzn6hw8/sHIj
 OSVmHRbUDEIyXdQrEJm3W/FQFX6zqCTqOfpPHvdWg03mVWLBpvQyFM/wIBs8AAHVs2JRvWygw
 laAbMifhey4SBY692e9UxYVYhNfsWlOMBon1RqyVvqE2acatkZdqGVPoE6ADdLE4b65MQZke9
 Azea25uSOujKOizz848EnU8LDp2olxpk8WkwyZWixToHvQZTSBVitmB7DXVwh61d2Yb45XPgW
 Ad7E2k1Al68qf9jwiJMQSyBZRcakbf50Nlu2h2f/3xWifVVNbUiwKqep9tjeD5p9jCHOEvT8U
 1VkpDjwHTqiISCWLvX+I6ewWwMIJ+m7wAAnOc6Qf6M5BsSLOTX9bPatuVjgrvtDwNkpKZti1b
 sZnptf/EhiNBXWRg7YLBfYLVQxW109h2/tHuzdNcqM6Icaw/eOhXFNvrXQMu3/9WtAfK4ckjq
 BBHiJ1o+1UDGXA7TCrXSp/Y8iz81cs7C/BMp73hrmKjA/INHKCx++nC1AJSGT53jYLPIW9p+B
 KaePkKIOQbogtBmBHlNCDmmb6KzNhGsZztzDEY6x/7Rrm8gk2T3ZXEE34jRrJgYJphNot9yjh
 lzaR7H08FKgxIcjjGJVE4VEPAnjK+PtAuSCxX7AEN+glkMbGrRLH3i7YRPdJEeQPuZ69uD1e0
 8Oo59kLIYC70Ihcs/T8GRcUc9IFkoO6RnfzMVeOgE5X/lpxhSi6uVjW6A44DzNVASbe4tiYIP
 oAcqXamxL9ccPwOFaQItpVlMTVPgJQD3y+X2n8zhGIrHMGvZ+7Ouqe+SRj94NmYRSG7jlzTd/
 cIb477drNfUaDK6GVopDPXLXQKx+OUbWxClZmgSfOEH9TSmAub/Mn0fh21pUBf23nwar5aXVn
 XIymvesLSPEcNBeIPtgnvL57F9vD6oDKQPFOvMblZGkn2vC424GPRzHkMmbZuQJHg3M1wn48u
 GTQj2nUuBKysvTuSnydoDE3ltOyTscMfA4pQ/foABULdS5dVCO6aSjc8EkFQd/6IomwNKv1Pm
 Q0lCm0Hrk8zpe272K0fHUgg7/aLo=
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

On 15.03.25 15:26, Simon Glass wrote:
> Free the memory used in tests to avoid a leak. Also unmap the addresses
> for sandbox.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add new patch to correct memory leaks in the ACPI test
>
>   test/dm/acpi.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/test/dm/acpi.c b/test/dm/acpi.c
> index 39a26bbb492..f98f9d1e74b 100644
> --- a/test/dm/acpi.c
> +++ b/test/dm/acpi.c
> @@ -309,6 +309,8 @@ static int dm_test_acpi_write_tables(struct unit_tes=
t_state *uts)
>   	}
>   	ut_asserteq(0, ctx.rsdt->entry[3]);
>   	ut_asserteq(0, ctx.xsdt->entry[3]);
> +	unmap_sysmem(buf);
> +	free(buf);
>
>   	return 0;
>   }
> @@ -386,6 +388,8 @@ static int dm_test_acpi_ctx_and_base_tables(struct u=
nit_test_state *uts)
>
>   	ut_asserteq(nomap_to_sysmem(rsdt), rsdp->rsdt_address);
>   	ut_asserteq(nomap_to_sysmem(xsdt), rsdp->xsdt_address);
> +	unmap_sysmem(buf);
> +	free(buf);
>
>   	return 0;
>   }
> @@ -428,6 +432,8 @@ static int dm_test_acpi_cmd_list(struct unit_test_st=
ate *uts)
>   	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0"=
,
>   			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
>   	ut_assert_console_end();
> +	unmap_sysmem(buf);
> +	free(buf);
>
>   	return 0;
>   }
> @@ -458,6 +464,8 @@ static int dm_test_acpi_cmd_dump(struct unit_test_st=
ate *uts)
>   	ut_assert_nextline("DMAR @ %16lx", addr);
>   	ut_assert_nextlines_are_dump(0x30);
>   	ut_assert_console_end();
> +	unmap_sysmem(buf);
> +	free(buf);
>
>   	return 0;
>   }
> @@ -642,6 +650,8 @@ static int dm_test_acpi_cmd_items(struct unit_test_s=
tate *uts)
>   	ut_assert_nextlines_are_dump(2);
>   	ut_assert_nextline("%s", "");
>   	ut_assert_console_end();
> +	unmap_sysmem(buf);
> +	free(buf);
>
>   	return 0;
>   }
> @@ -679,6 +689,8 @@ static int dm_test_acpi_cmd_set(struct unit_test_sta=
te *uts)
>   	ut_asserteq(addr, gd_acpi_start());
>
>   	ut_assert_console_end();
> +	unmap_sysmem(buf);
> +	free(buf);
>
>   	return 0;
>   }
> @@ -774,6 +786,7 @@ static int dm_test_acpi_find_table(struct unit_test_=
state *uts)
>
>   	/* Restore previous ACPI tables */
>   	gd_set_acpi_start(acpi_start);
> +	unmap_sysmem(buf);
>   	free(buf);
>
>   	return 0;

