Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49F3C021A6
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 16:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175C38056A;
	Sun, 16 Feb 2025 17:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JGX4cEpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2174807E1; Sun, 16 Feb 2025 17:51:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF3B801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 17:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739724655; x=1740329455; i=xypron.glpk@gmx.de;
 bh=vuJkKMpi4RPtwk9lABADvQPN7t9plZaaCMoHUsp7YQA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JGX4cEpJPoBtY9+GO44e/whqRWBzzuUZte/u2S592jzulBA1ngrqxiucXmuXnp3E
 8vhbS0/EaLggurws9BQKhd2QW1Q0+qfHJwSUmjL1ueD22sJTRLbRENsWlImqvRxKU
 cpGCN0bT3AIJs/TLm688P+MI3+Gjs5/qgnOsDHP/UulvxcjcIdA33UUdzNKhJYRLD
 OvT0ZeaRNDVPY30R3yzctAVKTGv+Ht1tmZAoq1NwbjGTETMAFjkkNs7Jt5vINvPbk
 5snH3HUm7NWT7YrnfwlnVGp3S2mgzc+2a+sY6irSeyQGjajtrUF/rG6neSJjs8dBV
 88bAJah37aKhJcJZ3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.1.210.90]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1sxjqg2tKD-00lC9f; Sun, 16
 Feb 2025 17:50:55 +0100
Date: Sun, 16 Feb 2025 17:50:53 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Yao Zi <ziyao@disroot.org>
CC: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] efi_loader: Clean up usage of structure jmp_buf_data
User-Agent: Thunderbird for Android
In-Reply-To: <Z7H1l-UwL-kELhn9@pie.lan>
References: <20250215155434.42749-2-ziyao@disroot.org>
 <a1484035-28d5-4dc8-8eff-d435d50572e7@gmx.de> <Z7H1l-UwL-kELhn9@pie.lan>
Message-ID: <B49E4AEE-E03C-494D-9577-81CB3DBC1FF4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:33LlE6/yTkval4+4yAmFz/xVJ34kjjatMPXA3NW4SsIpk6p/tqP
 IQGYnbT3F7Xki3YIU5d3DKbnCLw0shEMhu5POMaWMlsZcluZoO8vx/xl+xuDErJbyYrnZ2O
 xkjQ1zMEnnKkb9EybcVh2YaFMdERduo+gt344M0B3f3d9D4DpZ/37Cz7GhZTeJw6grC1uaN
 C4yVHkTir7OopZskG8GsA==
UI-OutboundReport: notjunk:1;M01:P0:Yxtk2zKJyR8=;sI6GGRWdV8QRQnzhPRRoNpsRQ/v
 8ULaN3CyeYmV1wb6C8C9/N2AOfvqzt+Uirmmcva2qORunrXDihRCUN0qFSp5Iern1X47jpnPq
 HWWZ6EmuLjou+B9QL7SkeJJx5oCh9M7izYlDCgUQZtr7P17S1IAMovv7E1TZnZP6H7Tc4lM4a
 VQgGYma/Jt9S5upjCzt0khtxNGwT7841SwYiceTGi/fsiRj70uwNgQaTsSX+YBHtq2m9aVPHy
 s5XgKQ0BkVnh1A5C/jIUnKS3tRfLhQgBeQrqiDzowG0Qe0AdEC58O6mTIeSpOYVvAEIa/dEbB
 Z4voPhhGEwSu2J0YPsftaJeZaQnZDVUQ9hgzBFqpdJp/T5jILl2689r8Xf2qG2P/lMDW/RJaR
 xiRxPQVHXJLWIn6thokis2m+riIBxdeIfi8dYYt+JKhWXEmxJ3lx/12tpPFLa0aA2p6LeSe6a
 OvDVvsd/uJjtIy76zNnUF8475yQovbb7lUjwG6yb8tutXAgGEL5ssKtHW2Po5D5LP+M6F+c3p
 /KrenX2SJxzmukfpaLvfDdl0E1inz6Q/oLKVYxSIx532gAVJrR+qfxVwsCXfDqhzLcpLueU0k
 3avl67QUcID0lncadw1xcSXpVpdvEjmrOm6dTFO058nbOedNPhXuomJNhLMr8ZvLHQN0hRPt8
 40QD3v4z6XVw59hSqE0RxprZwgOmZTxiHiviyswg41YNVzYqiSiDQ+naMwGln5/e6QBWLAqko
 v19eU/kdVje5vHFmpUH7jW50+BSTGrzdci26o365oSSHpJeTLq7eeSrO1SIwOoj1+IzafZioV
 FNJydOWI3NDrAidiMPdu0JUPCp8HHg+lO7a5EU9RmxkV3yiE9zOYSv/W8GvfqteYfu/sOBH44
 NwKV3i08J7PD54SGjgxLDWaRGOO9ziXUDIFncjXcH6owpBBOEaZIz4WtgHZ3bu9TcT8UamSQS
 lbPsP0+efOgzpbdaXwrThX2uST5JVOScsjYkY2pF586/d+7w8lqI5/5vMMgFtRTD/SFh/xqTc
 nw7drcnGINYkXGUFh4bQEnxmyccwOn8BsAsnwuzqgWJZ5Oz9/DTY5kQilBk5Ik2qBZHqGXOPM
 +7dtIh2TX7hz6XBCMXJR65xNvxzpMvBdS4xvX0hA/mkmXNB/VZbaJhrQWjJijpNWqtiGEZauv
 YykpLaD3481aCB4UxaA8rFDEhik1m55dOx47X96pAswqRS06AYjm9sLKp7pAc1GfdrIf3d8U5
 wFkQMaPk/oK93SsAVQ/56b12grnhlWB17v0/UXBxHq+5wUUQqNHqDxMixHb1bjtiVhTRiICIs
 +AgEkvQzIvEg0U+CvJwE5iCt8/1lA/1klclPEIfX74s9oq4cjWuIj6r4cTksc4oAAea+Y4DIW
 fYp52IhcLhHnz2x2TWHqARi1DiEA+x/LJyzYzPh9lSpDoiQxQVO5oZ8Yuu
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

Am 16=2E Februar 2025 15:26:31 MEZ schrieb Yao Zi <ziyao@disroot=2Eorg>:
>On Sat, Feb 15, 2025 at 05:58:18PM +0100, Heinrich Schuchardt wrote:
>> On 15=2E02=2E25 16:54, Yao Zi wrote:
>> > Structure jmp_buf_data provides the underlying format of jmp_buf, whi=
ch
>> > we actually don't care about=2E Clean up existing code to use the sta=
ndard
>> > jmp_buf type=2E This introduces no functional change=2E
>> >=20
>> > Signed-off-by: Yao Zi <ziyao@disroot=2Eorg>
>> > ---
>> >   include/efi_loader=2Eh          | 4 ++--
>> >   lib/efi_loader/efi_boottime=2Ec | 8 ++++----
>> >   2 files changed, 6 insertions(+), 6 deletions(-)
>> >=20
>> > diff --git a/include/efi_loader=2Eh b/include/efi_loader=2Eh
>> > index dcae6a731a0=2E=2E4afe8b9c859 100644
>> > --- a/include/efi_loader=2Eh
>> > +++ b/include/efi_loader=2Eh
>> > @@ -15,13 +15,13 @@
>> >   #include <efi_api=2Eh>
>> >   #include <image=2Eh>
>> >   #include <pe=2Eh>
>> > +#include <asm/setjmp=2Eh>
>>=20
>> Thanks for this suggestion=2E
>>=20
>> lib/efi_loader/efi_boottime=2Ec already has this include=2E
>> We don't need to include it globally=2E
>
>We need to include it, or in files that doesn't include asm/setjmp=2Eh
>directly, type jmp_buf is unknown, failing the compilation=2E

There is no such file=2E

>
>> The rest looks fine=2E
>>=20
>> Best regards
>>=20
>> Heinrich
>
>Thanks,
>Yao Zi
>
>>=20
>> >   #include <linux/list=2Eh>
>> >   #include <linux/sizes=2Eh>
>> >   #include <linux/oid_registry=2Eh>
>> >=20
>> >   struct blk_desc;
>> >   struct bootflow;
>> > -struct jmp_buf_data;
>> >=20
>> >   #if CONFIG_IS_ENABLED(EFI_LOADER)
>> >=20
>> > @@ -485,7 +485,7 @@ struct efi_loaded_image_obj {
>> >   	efi_status_t *exit_status;
>> >   	efi_uintn_t *exit_data_size;
>> >   	u16 **exit_data;
>> > -	struct jmp_buf_data *exit_jmp;
>> > +	jmp_buf *exit_jmp;
>> >   	EFIAPI efi_status_t (*entry)(efi_handle_t image_handle,
>> >   				     struct efi_system_table *st);
>> >   	u16 image_type;
>> > diff --git a/lib/efi_loader/efi_boottime=2Ec b/lib/efi_loader/efi_boo=
ttime=2Ec
>> > index 5164cb15986=2E=2E80c56b1ee46 100644
>> > --- a/lib/efi_loader/efi_boottime=2Ec
>> > +++ b/lib/efi_loader/efi_boottime=2Ec
>> > @@ -3199,7 +3199,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_=
t image_handle,
>> >   	void *info;
>> >   	efi_handle_t parent_image =3D current_image;
>> >   	efi_status_t exit_status;
>> > -	struct jmp_buf_data exit_jmp;
>> > +	jmp_buf exit_jmp;
>> >=20
>> >   	EFI_ENTRY("%p, %p, %p", image_handle, exit_data_size, exit_data);
>> >=20
>> > @@ -3238,7 +3238,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_=
t image_handle,
>> >   	}
>> >=20
>> >   	/* call the image! */
>> > -	if (setjmp(&exit_jmp)) {
>> > +	if (setjmp(exit_jmp)) {
>> >   		/*
>> >   		 * We called the entry point of the child image with EFI_CALL
>> >   		 * in the lines below=2E The child image called the Exit() boot
>> > @@ -3444,7 +3444,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_=
t image_handle,
>> >   	struct efi_loaded_image *loaded_image_protocol;
>> >   	struct efi_loaded_image_obj *image_obj =3D
>> >   		(struct efi_loaded_image_obj *)image_handle;
>> > -	struct jmp_buf_data *exit_jmp;
>> > +	jmp_buf *exit_jmp;
>> >=20
>> >   	EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
>> >   		  exit_data_size, exit_data);
>> > @@ -3511,7 +3511,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_=
t image_handle,
>> >   	 */
>> >   	efi_restore_gd();
>> >=20
>> > -	longjmp(exit_jmp, 1);
>> > +	longjmp(*exit_jmp, 1);
>> >=20
>> >   	panic("EFI application exited");
>> >   out:
>>=20

