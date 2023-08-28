Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D51C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2533C8647F;
	Tue, 29 Aug 2023 00:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VoO7FmLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F7E86482; Tue, 29 Aug 2023 00:53:37 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8AA28644E
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693263212; x=1693868012; i=xypron.glpk@gmx.de;
 bh=u4h93QsxM4wWx52R/VGz6VTP1smK0EKjxfzgiyM2bNQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VoO7FmLlGFTOX8CDmQMqS7UEQLCVC6HNNNS7+FFspc4Rp2zkcG1XDZObFZgvnu2tWxrBOQE
 DBiw4cDjnXtXa2dhyQyg0UTPPUWg+LydPjqrITFd1Oxgt0ndZoMnY7M9Ju/JONiKeNNLrhoxG
 nfh0FWYpVq4YeUosPE3i9uE/HLVquWAlrdjR1WdAuw8hu4TCiniPZqYdwkWAluaqhpYHStoxn
 4GlF1tJvV063Aq0gtSjBXvJOroH8lQqqkGNjWBWkp6MoWGHyijfudDVDy1/qmaCfEfeQj3EEH
 zgwOXaRb7/iNn2McqDxDC3ma3niJBon7sihnlvBvJXRlENeVn/sQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1q8TmC3LD9-00TU2O; Tue, 29
 Aug 2023 00:53:31 +0200
Message-ID: <9299df67-7e0f-44cc-b4c5-29b337116e4c@gmx.de>
Date: Tue, 29 Aug 2023 00:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] cmd: gpt: Add command to set bootable flags
Content-Language: en-US, de-DE
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Enric Balletbo i Serra <eballetb@redhat.com>, u-boot@lists.denx.de
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-6-JPEWhacker@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230828215623.3727536-6-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0shl0z0vhKkx130hr620DB/xOtKsm2Ier5Mu4L8gjf7Ce9yhtxw
 zuOvxdry9AoGtu2mGzbHEPhGJjXB2dl0G5eIc1s5KDwMy62i3mNc/chiDIat95olMka95s2
 ONKwGnfXAvQ9907AVhlvUHNDwuVDq7UvIA9hBhsoEIxbs51L3LJJ2tjbJhAMBeE7bKjKWYY
 ilzdOMSvFVJH/d9VGIyoQ==
UI-OutboundReport: notjunk:1;M01:P0:FLd68UahSRQ=;8/Cx09AxcVDAy4vt33dv2ahXSKj
 k8yb+nO1mzL12eZH1ueUtWQa/N5QUQuQTp6tcRuI+bYKhZBaMeGRSkDVO+RbkIFj2oPwD/UHE
 wjN/+pHh6bWJ049zm0ByEnkWcppgHRWHAuwIL0nSGOy9xOhnj7ijpBM2FUKo5qcDBBp69cKH9
 aCD+2WzRXYGs2dKUkXaowmFea2sqQXSjo2jutqXxef8m0W0dq5a6b5QwY31j0I3imsjbAMr2+
 cVXfHwoB/WIBkA3FSjwc/LIVdBrDi1Dcahmi5mxRN4VL5IJCTvsLn+JiqsHdQgaoGQoVzPYYZ
 Ubcx8ShVppK4B8NOXsPa69QGkCzULben5lEUiKJgdd3lxQ5hXaMNo2HVz3cJP0x6ZYcIIXq1X
 9AjBBN5lzCkGl2/s/HFyDiU8/oRO4T6W/A3bu6XtD3k83wY2/85lI2e/s+SWmZNR/kgJaOHTr
 D34la2N0VyA53yGfDSKqAIRY1D+Ok0QclvVpmGYxSQSggfunngA3Mi2qSQdqL0aoS2Masa46I
 p1/IPpPUAibrUluB6+UMpM+PYucHB2nhhoonW2cRMo+5+LgTwVlWYDx63EDKSMUNrbm5Q8Slk
 OSVYQBizt4DE30bS+FCIjIDkfRzNKrqjupFZEVGC84+mSPKWIRxYcWHGOc1U7/H5tZ5Ru2wvu
 mzbKCUmhco3xuazDk3cv1ReYxXKq77qes8DeTldqN71dEVyHa54JQuiBCS9qdN2KOVYuqwytA
 Rpionqn/DRb9Ef+5fn/kzexaBQnapuDFw7+7YGcffm+YKQwa+HeMefazNlYcv+Cc+yBYfKJGI
 TrVyWT1yDIT9xshlT9aYPlCHdn96UzkE8/xdlcfeP1zTasNxiWOEdJ5BGdvXw2dqnZ3sCoWkg
 YdkvpvJGQAY+590rEx1ICUczvucajeC93zBZxZVsTjtSiUVHRizR0GGBMQ6f10hGxIVQG/pVs
 0sD0gwuJoa+Rt/RzjroTzIG4gz4=
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

On 8/28/23 23:56, Joshua Watt wrote:
> Adds a command that can be used to modify the GPT partition table to
> indicate which partitions should have the bootable flag set
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   cmd/gpt.c                 | 80 +++++++++++++++++++++++++++++++++++++++
>   doc/usage/cmd/gpt.rst     | 12 ++++++
>   test/py/tests/test_gpt.py | 22 +++++++++++
>   3 files changed, 114 insertions(+)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index c6c8282ac9..45fbe07404 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -972,6 +972,81 @@ static int do_rename_gpt_parts(struct blk_desc *dev=
_desc, char *subcomm,
>   	free(partitions_list);
>   	return ret;
>   }
> +
> +/**
> + * gpt_set_bootable() - Set bootable flags for partitions
> + *
> + * Sets the bootable flag for any partition names in the comma separate=
d list of
> + * partition names. Any partitions not in the list have their bootable =
flag
> + * cleared
> + *
> + * @desc: block device descriptor
> + * @name: Comma separated list of partition names
> + *
> + * @Return: '0' on success and -ve error on failure
> + */
> +static int gpt_set_bootable(struct blk_desc *blk_dev_desc, char *const =
part_list)
> +{
> +	char *name;
> +	char disk_guid[UUID_STR_LEN + 1];
> +	struct list_head *pos;
> +	struct disk_part *curr;
> +	struct disk_partition *partitions =3D NULL;
> +	int part_count =3D 0;
> +	int ret =3D get_disk_guid(blk_dev_desc, disk_guid);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D get_gpt_info(blk_dev_desc);
> +	if (ret <=3D 0)
> +		goto out;
> +
> +	part_count =3D ret;
> +	partitions =3D malloc(sizeof(*partitions) * part_count);
> +	if (!partitions) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Copy partitions and clear bootable flag */
> +	part_count =3D 0;
> +	list_for_each(pos, &disk_partitions) {
> +		curr =3D list_entry(pos, struct disk_part, list);
> +		partitions[part_count] =3D curr->gpt_part_info;
> +		partitions[part_count].bootable &=3D ~PART_BOOTABLE;
> +		part_count++;
> +	}
> +
> +	name =3D strtok(part_list, ",");
> +	while (name) {
> +		bool found =3D false;
> +
> +		for (int i =3D 0; i < part_count; i++) {
> +			if (strcmp((char *)partitions[i].name, name) =3D=3D 0) {
> +				partitions[i].bootable |=3D PART_BOOTABLE;
> +				found =3D true;
> +			}
> +		}
> +
> +		if (!found) {
> +			printf("Warning: No partition matching '%s' found\n",
> +			       name);
> +		}
> +
> +		name =3D strtok(NULL, ",");
> +	}
> +
> +	ret =3D gpt_restore(blk_dev_desc, disk_guid, partitions, part_count);
> +
> +out:
> +	del_gpt_info();
> +
> +	if (partitions)
> +		free(partitions);
> +
> +	return ret;
> +}
>   #endif
>
>   /**
> @@ -1031,6 +1106,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag,=
 int argc, char *const argv[])
>   	} else if ((strcmp(argv[1], "swap") =3D=3D 0) ||
>   		   (strcmp(argv[1], "rename") =3D=3D 0)) {
>   		ret =3D do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5])=
;
> +	} else if ((strcmp(argv[1], "set-bootable") =3D=3D 0)) {
> +		ret =3D gpt_set_bootable(blk_dev_desc, argv[4]);
>   #endif
>   	} else {
>   		return CMD_RET_USAGE;
> @@ -1082,8 +1159,11 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
>   	"      and vice-versa\n"
>   	" gpt rename <interface> <dev> <part> <name>\n"
>   	"    - rename the specified partition\n"
> +	" gpt set-bootable <interface> <dev> <list>\n"
> +	"    - make partition names in list bootable\n"
>   	" Example usage:\n"
>   	" gpt swap mmc 0 foo bar\n"
>   	" gpt rename mmc 0 3 foo\n"
> +	" gpt set-bootable mmc 0 boot_a,boot_b\n"
>   #endif
>   );
> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> index b505b159d0..288dd365c0 100644
> --- a/doc/usage/cmd/gpt.rst
> +++ b/doc/usage/cmd/gpt.rst
> @@ -13,6 +13,7 @@ Synopsis
>       gpt read <interface> <dev> [<varname>]
>       gpt rename <interface> <dev> <part> <name>
>       gpt repair <interface> <dev>
> +    gpt set-bootable <interface> <dev> <partition list>
>       gpt setenv <interface> <dev> <partition name>
>       gpt swap <interface> <dev> <name1> <name2>
>       gpt verify <interface> <dev> [<partition string>]
> @@ -90,6 +91,13 @@ gpt repair
>
>   Repairs the GPT partition tables if it they become corrupted.
>
> +gpt set-bootable
> +~~~~~~~~~~~~~~~~
> +
> +Sets the bootable flag for all partitions in the table. If the partitio=
n name
> +is in 'partition list' (separated by ','), the bootable flag is set, ot=
herwise
> +it is cleared. CONFIG_CMD_GPT_RENAME=3Dy is required.

Why should this feature be related to CONFIG_CMD_GPT_RENAME?

Why do we need this sub-command? You can use gpt read and gpt write for
this rarely needed manipulation.

Best regards

Heinrich

> +
>   gpt setenv
>   ~~~~~~~~~~
>
> @@ -187,3 +195,7 @@ Get the GUID for a disk::
>       =3D> gpt guid mmc gpt_disk_uuid
>       =3D> echo ${gpt_disk_uuid}
>       bec9fc2a-86c1-483d-8a0e-0109732277d7
> +
> +Set the bootable flag for the 'boot' partition and clear it for all oth=
ers::
> +
> +    =3D> gpt set-bootable mmc 0 boot
> diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> index 946858800d..5d23f9b292 100644
> --- a/test/py/tests/test_gpt.py
> +++ b/test/py/tests/test_gpt.py
> @@ -222,6 +222,28 @@ def test_gpt_swap_partitions(state_disk_image, u_bo=
ot_console):
>       assert '0x00000800	0x00000fff	"part2"' in output
>       assert '0x00001000	0x00001bff	"part1"' in output
>
> +@pytest.mark.buildconfigspec('cmd_gpt')
> +@pytest.mark.buildconfigspec('cmd_gpt_rename')
> +@pytest.mark.buildconfigspec('cmd_part')
> +@pytest.mark.requiredtool('sgdisk')
> +def test_gpt_set_bootable(state_disk_image, u_boot_console):
> +    """Test the gpt set-bootable command."""
> +
> +    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
> +    parts =3D ('part2', 'part1')
> +    for bootable in parts:
> +        output =3D u_boot_console.run_command(f'gpt set-bootable host 0=
 {bootable}')
> +        assert 'success!' in output
> +
> +        for p in parts:
> +            output =3D u_boot_console.run_command(f'gpt setenv host 0 {=
p}')
> +            assert 'success!' in output
> +            output =3D u_boot_console.run_command('echo ${gpt_partition=
_bootable}')
> +            if p =3D=3D bootable:
> +                assert output.rstrip() =3D=3D '1'
> +            else:
> +                assert output.rstrip() =3D=3D '0'
> +
>   @pytest.mark.boardspec('sandbox')
>   @pytest.mark.buildconfigspec('cmd_gpt')
>   @pytest.mark.buildconfigspec('cmd_part')

