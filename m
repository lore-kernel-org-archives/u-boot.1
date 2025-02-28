Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2C3C282C1
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 15:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F35809D4;
	Fri, 28 Feb 2025 16:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lr3Zg8kw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E0D810F5; Fri, 28 Feb 2025 16:50:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF92807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 16:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740757852; x=1741362652; i=xypron.glpk@gmx.de;
 bh=MS+k1yc8lasHXvRsLkQGwZJ3O2TX9GKvYvHsp5+27cQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lr3Zg8kwLSy6gkdT7Wu3LjJ0sf3AxjmR4OU/NKocfcSBAAHQMIIOqZB+LXCqVkcN
 do6qqHDEs/6lOr4Hpm3VzNTVWWdNVkpjaTVYoSrwYpqEJwFXN/iqU41gAtExYZ6VX
 4miPiuglBkMSUesA78+nq2aP1cRk6nF0pbaaI4mS/TXTJTaHdEjFihNL/pQ/el9aO
 bESGVE74BbSQ1RjSxadITfZsrzClH0iudHzNiYuJACR+FrFzhe3U2cjsxtjKsCku2
 M5GPL1oFG6laL3mFTP/PdDWAt68JjUecD2hq94+WIOmO57PIzd04eA6QZvGXKtw7j
 X+e7RAJ4tY5bHUn97A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1t691z0Sd1-00w6wP; Fri, 28
 Feb 2025 16:50:52 +0100
Message-ID: <9bdc7716-335f-47b7-be3a-53088534b8c4@gmx.de>
Date: Fri, 28 Feb 2025 16:50:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Clean up usage of structure jmp_buf_data
To: Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250215155434.42749-2-ziyao@disroot.org>
 <a1484035-28d5-4dc8-8eff-d435d50572e7@gmx.de> <Z7H1l-UwL-kELhn9@pie.lan>
 <B49E4AEE-E03C-494D-9577-81CB3DBC1FF4@gmx.de> <Z7Ih-axCzeGsbqX3@pie.lan>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <Z7Ih-axCzeGsbqX3@pie.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ixjut5AibqM/siasQCfdivTmQecj7e4nhv/9pIhkLkO7Zm0R2GX
 7xl+QrYpOZ/223/oTHz25aqvpE5O935wwdey12MiCEXY8RiYn3B9/A/fMI44dSVKBRCLkso
 rdn+22rPWC6ViZYKBex+OocN4V0bRgx9OPzbDs0KqJeOtTHG8J6MuTCMAqylKj3six68cD+
 +2njR/n/bq64Lmv+LcCMQ==
UI-OutboundReport: notjunk:1;M01:P0:qO5Z9ytCCjE=;N6JqQInGj4Xr9YdKw4oqIBQTDLo
 TZ4nBooAn8u/D0nosIvqniHagi5X0SrePvsrstNlthPhsTYBZG0wFC0hn/9E7NCgPZjKAvVyB
 f6kTfBstcX87HF/vLrXy1FgFDehuSTh4Y/xl2rRBLOFZjoXnUNXvSOZ9RgM9s+L+1pDoHBKRV
 sFQzo4DnbyEhuT+bUsi+tHeyHnaiketS8QONVBJRiVs6mbGQn50y5emSLBHcAQ4Pzn/lhDXfV
 EeKZOeeKYNaJZEFJL2AHJCeNNtHZbci+NCnQuzQrxtlMzHFhCl2MlpE6bAx9FQ9h1NZUOMkws
 igQsYEwg9ljTR4Kzf/+nhEdRZ8NdKA/clOzfkBV9s3kU+6ykGclsDvnTE1WL5MFScPgtAbX6e
 6ZHAogpxCsDY4wO2Zq+8cQEv3QxBrQjP3M5OUHYflbFubSC7scyxTlKsJ3IUt+icK0BVX+OUJ
 FOEqZ9zm60UtggTceznnSnsLizxfmDkKNzLxJat9Dc2lVWllblA24C/6UeOA1xXTGjvqR1+kK
 S4ovLMzOYD8wQgKw3NRMHiS3R8CnMlI7d6DqTJoszcJuoC1CVrMjC6qpEvzenPpN9PnO287ra
 fEJprbIAE9jSYdUdJiB0K7eiBOM7+S979UjMtkwz5zlasHaP49CX+gTu5c9XMpBCpX4NmVQdH
 fOl+Bve7bP0Br9urnIGzOQFFv4hooAHGj0xBQwp5YRDcsqkzyjnqXvmsqNcNLvGvYgLbjNLmP
 2Igy3UFFr6ZyKGWrIMxZVyCsGi92pIYTfercu3O/aBI2rWhlpoBV8H50+284VAWMg9atH1/g9
 GftgYdA4unPmyb63GvlmofuGgVsz5yOArZF5p2g+RTM3qFu+tJX24mD0P6nWdQYDalTckB3uI
 b2ObUGM11pq611vi3tkKoPbKB6u0zLUoU+0+6pmzzqwXqhktubbqIHrlwBCoLGyiIjzLQYVKI
 ubE2Do2R2Jfvyu9Eki4xP2cuApDoJW+fIhRAz4fWsct5xleRaYFwDEqtucVh0Da1/KEaLI/Mo
 DmdXnlurO9MIz5U9GYyXQkiE6VHJExQaw9FJf82EJc7xIeZti8OyyBNdGJbxmT+Bt1CxSeAxY
 YwSnXWNpHj2bBpaSuHHdFB3TJW2HpT95OmcUIgaKuM12nRG0WLRDxB73qLmMHadBmK7NhkjeZ
 bS51AegPMYcn8sm8MYhtkYsvHl/aokKRIgqFxUC8sGm/H8wyFMCpB8oLv4NXZym5AGktGcfRs
 lWSRUaOoqu6hXV7n6ccZMXG6k2H4dEyBLTHDJLzaLCfaEuyeX3zySJLHa5AzM0lqbP2Sd6wap
 2zGnWDm1v5gSULkO/sBZE0xZ0HxUckyapCSMcJjOHGJtAChPE4UQWvVbWT4gEQ72Ua9A2ILdZ
 +qGxA1+97MnzprIJy4S1zI35v0GJF1+GpuOt3c9nNijXtWMLTGbUYjnSdT
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

On 16.02.25 18:36, Yao Zi wrote:
> On Sun, Feb 16, 2025 at 05:50:53PM +0100, Heinrich Schuchardt wrote:
>> Am 16. Februar 2025 15:26:31 MEZ schrieb Yao Zi <ziyao@disroot.org>:
>>> On Sat, Feb 15, 2025 at 05:58:18PM +0100, Heinrich Schuchardt wrote:
>>>> On 15.02.25 16:54, Yao Zi wrote:
>>>>> Structure jmp_buf_data provides the underlying format of jmp_buf, wh=
ich
>>>>> we actually don't care about. Clean up existing code to use the stan=
dard
>>>>> jmp_buf type. This introduces no functional change.
>>>>>
>>>>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>>>>> ---
>>>>>    include/efi_loader.h          | 4 ++--
>>>>>    lib/efi_loader/efi_boottime.c | 8 ++++----
>>>>>    2 files changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>>>> index dcae6a731a0..4afe8b9c859 100644
>>>>> --- a/include/efi_loader.h
>>>>> +++ b/include/efi_loader.h
>>>>> @@ -15,13 +15,13 @@
>>>>>    #include <efi_api.h>
>>>>>    #include <image.h>
>>>>>    #include <pe.h>
>>>>> +#include <asm/setjmp.h>
>>>>
>>>> Thanks for this suggestion.
>>>>
>>>> lib/efi_loader/efi_boottime.c already has this include.
>>>> We don't need to include it globally.
>>>
>>> We need to include it, or in files that doesn't include asm/setjmp.h
>>> directly, type jmp_buf is unknown, failing the compilation.
>>
>
> After removing the include, I get bunches of compilation errors like
>
> 	In file included from lib/efi_loader/efi_file.c:11:
> 	include/efi_loader.h:487:9: error: unknown type name 'jmp_buf'
> 	  487 |         jmp_buf *exit_jmp;
> 	      |         ^~~~~~~
> 	In file included from lib/efi_loader/efi_load_options.c:13:
> 	include/efi_loader.h:487:9: error: unknown type name 'jmp_buf'
> 	  487 |         jmp_buf *exit_jmp;
> 	      |         ^~~~~~~
>
>> There is no such file.
>
> So I don't think it's true. By "files that doesn't include asm/setjmp.h
> directly", I mean those which include efi_loader.h but don't include
> asm/setjmp.h.

Building with your patch fails on architectures that don't implement
setjmp because asm/setjmp.h does not exist on these.

Best regards

Heinrich

>
>>>
>>>> The rest looks fine.
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>
>>> Thanks,
>>> Yao Zi
>>>
>>>>
>>>>>    #include <linux/list.h>
>>>>>    #include <linux/sizes.h>
>>>>>    #include <linux/oid_registry.h>
>>>>>
>>>>>    struct blk_desc;
>>>>>    struct bootflow;
>>>>> -struct jmp_buf_data;
>>>>>
>>>>>    #if CONFIG_IS_ENABLED(EFI_LOADER)
>>>>>
>>>>> @@ -485,7 +485,7 @@ struct efi_loaded_image_obj {
>>>>>    	efi_status_t *exit_status;
>>>>>    	efi_uintn_t *exit_data_size;
>>>>>    	u16 **exit_data;
>>>>> -	struct jmp_buf_data *exit_jmp;
>>>>> +	jmp_buf *exit_jmp;
>>>>>    	EFIAPI efi_status_t (*entry)(efi_handle_t image_handle,
>>>>>    				     struct efi_system_table *st);
>>>>>    	u16 image_type;
>>>>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boot=
time.c
>>>>> index 5164cb15986..80c56b1ee46 100644
>>>>> --- a/lib/efi_loader/efi_boottime.c
>>>>> +++ b/lib/efi_loader/efi_boottime.c
>>>>> @@ -3199,7 +3199,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle=
_t image_handle,
>>>>>    	void *info;
>>>>>    	efi_handle_t parent_image =3D current_image;
>>>>>    	efi_status_t exit_status;
>>>>> -	struct jmp_buf_data exit_jmp;
>>>>> +	jmp_buf exit_jmp;
>>>>>
>>>>>    	EFI_ENTRY("%p, %p, %p", image_handle, exit_data_size, exit_data)=
;
>>>>>
>>>>> @@ -3238,7 +3238,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle=
_t image_handle,
>>>>>    	}
>>>>>
>>>>>    	/* call the image! */
>>>>> -	if (setjmp(&exit_jmp)) {
>>>>> +	if (setjmp(exit_jmp)) {
>>>>>    		/*
>>>>>    		 * We called the entry point of the child image with EFI_CALL
>>>>>    		 * in the lines below. The child image called the Exit() boot
>>>>> @@ -3444,7 +3444,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle=
_t image_handle,
>>>>>    	struct efi_loaded_image *loaded_image_protocol;
>>>>>    	struct efi_loaded_image_obj *image_obj =3D
>>>>>    		(struct efi_loaded_image_obj *)image_handle;
>>>>> -	struct jmp_buf_data *exit_jmp;
>>>>> +	jmp_buf *exit_jmp;
>>>>>
>>>>>    	EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
>>>>>    		  exit_data_size, exit_data);
>>>>> @@ -3511,7 +3511,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle=
_t image_handle,
>>>>>    	 */
>>>>>    	efi_restore_gd();
>>>>>
>>>>> -	longjmp(exit_jmp, 1);
>>>>> +	longjmp(*exit_jmp, 1);
>>>>>
>>>>>    	panic("EFI application exited");
>>>>>    out:
>>>>
>>

