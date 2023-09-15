Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81D9EE0205
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 02:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79DB864EE;
	Fri, 15 Sep 2023 04:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Mzq1Hr55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B39865D0; Fri, 15 Sep 2023 04:39:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916E386489
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 04:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694745581; x=1695350381; i=xypron.glpk@gmx.de;
 bh=mGukCXali2EsMxU3JX6vgRAbDw9AyKZqTp+4q7Kjzqs=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=Mzq1Hr55jqQeW2RrQmDLfcW9wqR/DmkS9cUa+Mu6XEwgHk7tWyc3uILDt7Oy+eTKVoIxl4qBpaX
 aBcR3vR7+TwNasMeEcjaVKc1uPCeKmH1iMuwn+2nVGU1WAQhZcqTTVTK9T80I1ycLorSfM9xB9oWi
 efOBuviK5nycJemSK3q079VxegbLxlywpyIRM0rM+3pbIuSunqCB09HoVFyq9ztlhpu7fZtQi9fvX
 GSTxzP+Nv3Gel7rE3JWfH1E9OS2MIcK84Ii1XhX2mqSxVP/usLZVl9VuYBk4g8/sp3uCAzxwBMc4W
 kieZbcUvr9I25IEgWJKKfajmDsHM586hBgQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1rTZ6J3hTT-00oVfG; Fri, 15
 Sep 2023 04:39:41 +0200
Date: Fri, 15 Sep 2023 04:39:39 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 27/27] qconfig: Update the documentation
User-Agent: K-9 Mail for Android
In-Reply-To: <20230915002236.798760-28-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
 <20230915002236.798760-28-sjg@chromium.org>
Message-ID: <EAEB2C14-4192-47FC-8AB8-E3CF15987361@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/1kPCqylpLWYQ41kY+dW/Au++mZZOMvip+AhReRxMVu3fIrB6W2
 1kgAc6dy32EzEYFYDsDcBNVA+gW4k/wG4kW9o5oNlQHVoh587Zci3aujHKlm3eDGke+ChyU
 dmRSGfRknhw5GsrUbStzU7xgZGwlJjNxGodbFRpVYag3AwmYlN9q1z1Z3TzWgNG5fDXQypm
 DKl/MV3owHPw6Up7HiV2Q==
UI-OutboundReport: notjunk:1;M01:P0:eOS5AGuud/E=;qMSZ0SXUwju+ZhO0Zi52ZgfVFkj
 2r6MF6oY3Ev11wyhbkGkySK59eF0M+3hLPcbjp/nAZwq01TQH+pCkDG+/PBP+o0pb9tm7Z4S5
 OpQJu3PQESXlT3Lv0FLOpbxKvRCPvAwJLhP31JWjJU9jVCjEa9ksHll2ZtBkEOBOGzbqKoLv3
 ju6wfn2GItSiU4vKS465GlKIqJ8SxlHzc4M0xDh28P7KVm4DitX8n8hEtK4f6xqH7BOcJ/Yob
 RNEeVxm5Nl35GkP0B+/ZuM2G5I9A019FSsNGMrCdQyoCmhAhajdKA2HbOoi9ImE4DRT43Anrz
 j/7/gVL7dJ559uQKQh5gw09YkMWrCXqc9tRX/m1XFZdbrAsKTvgs+WSIIE/GjS8kvVe0x+qIs
 qLY8lseUUHJowyxDoJDYz87pWwmSZoycRtb8KSELQAuGn2D9j0Sjcu4mE0ApcWsj4AyIeP8Si
 TS4t+o5XSTAQcCUafKB3lT7NlohulCgUF4xLvSDX/s6FLFJwgd25tFfJ56OEYUE5j3iPv+t6H
 f6MgySwqJYjf0AxahhU//zOtYGIQvIm46T36EfQ1nLezdZGPXgtLO67gC4tzoiV81vkQep4Hw
 pM4+ZL6iu5VI2yf028l1pMb6F5VEGvVU7JOW0UflG/eClAMM6+vCWbi52/as2YUiHIX8IZFBe
 1n2AWgxQK0itycmrQUP2/TQBMoPRa7h0F3lXxwTMVkj3T0b8qGJ5FgnJ6ZW4pD9NEE5Emxbf3
 YVpZapiIi9SWI7Np/j2J9gr64ZnrxREeaL+Lu2TaP/iSLiKTiwBnqTT0MpPCUo+URFhWqf6U8
 RgFIc4IlQ+n0lvnKoHhGaCtCC8icqHYUxhOq9h9+/11gdmhafR7N1u6jrE6rkhbt09nUOcHXi
 5Vqnh/j+yiEJUZ7mulUc2OCyd/G/Xg+d/CqicARRgjC0eLSyX1g7uJKBtLO2z92PTsSFiWr+B
 qLBf+dP8aLlfrHYa5O2GNjUnYZU=
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



Am 15=2E September 2023 02:22:29 MESZ schrieb Simon Glass <sjg@chromium=2E=
org>:
>Update qconfig's documentation to better reflect its new purpose in life=
=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v2:
>- Reinstate the -C option
>
> doc/develop/index=2Erst                       |   2 +-
> doc/develop/{moveconfig=2Erst =3D> qconfig=2Erst} | 144 +++++-----------=
----
> 2 files changed, 38 insertions(+), 108 deletions(-)
> rename doc/develop/{moveconfig=2Erst =3D> qconfig=2Erst} (61%)
>
>diff --git a/doc/develop/index=2Erst b/doc/develop/index=2Erst
>index 0d12484ace8a=2E=2E003cdfccf112 100644
>--- a/doc/develop/index=2Erst
>+++ b/doc/develop/index=2Erst
>@@ -88,7 +88,7 @@ Refactoring
>=20
>    checkpatch
>    coccinelle
>-   moveconfig
>+   qconfig
>=20
> Code quality
> ------------
>diff --git a/doc/develop/moveconfig=2Erst b/doc/develop/qconfig=2Erst
>similarity index 61%
>rename from doc/develop/moveconfig=2Erst
>rename to doc/develop/qconfig=2Erst
>index ad8596e6c61a=2E=2E111e2b2545d9 100644
>--- a/doc/develop/moveconfig=2Erst
>+++ b/doc/develop/qconfig=2Erst
>@@ -1,100 +1,37 @@
> =2E=2E SPDX-License-Identifier: GPL-2=2E0+
>=20
>-moveconfig - Migrating and querying CONFIG options
>-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>+qconfig - Querying CONFIG options
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>-Since Kconfig was introduced to U-Boot, we have worked on moving
>-config options from headers to Kconfig (defconfig)=2E
>+It is not possible to see all the CONFIG options used by a board without
>+building its `=2Econfig` file=2E This tool allowing this to be done effi=
ciently for

%s/allowing/allows/


>+all boards, or a subset, writing the results to a unified database file=
=2E
>=20
>-This tool intends to help this tremendous work=2E
>+This database can be queried, to find boards which used a certain combin=
ation
>+of options, to aid in discovering Kconfig options which imply others=2E
>+
>+The tool also permits syncing of defconfigs, which corrects the ordering=
 and

%s/syncing/synchronizing/


>+drops options which are implied by others=2E
>+
>+Finally, it allow scanning the source code to look for inconsistencies i=
n the

%s/allow/allows/


>+use of Kconfig options=2E
>=20
> Installing
> ----------


%s/Installing/Installation/

>=20
> You may need to install 'python3-asteval' for the 'asteval' module=2E
>=20
>-Usage
>------
>-
>-First, you must edit the Kconfig to add the menu entries for the configs
>-you are moving=2E
>-
>-Then run this tool giving CONFIG names you want to move=2E
>-For example, if you want to move CONFIG_CMD_USB and CONFIG_TEXT_BASE,
>-simply type as follows::
>-
>-  $ tools/moveconfig=2Epy CONFIG_CMD_USB CONFIG_TEXT_BASE
>-
>-The tool walks through all the defconfig files and move the given CONFIG=
s=2E
>-
>-The log is also displayed on the terminal=2E
>-
>-The log is printed for each defconfig as follows::
>-
>-  <defconfig_name>
>-     <action1>
>-     <action2>
>-     <action3>
>-     =2E=2E=2E
>-
>-`<defconfig_name>` is the name of the defconfig=2E
>-
>-`<action*>` shows what the tool did for that defconfig=2E
>-It looks like one of the following:
>-
>- - Move 'CONFIG\_=2E=2E=2E '
>-   This config option was moved to the defconfig
>-
>- - CONFIG\_=2E=2E=2E is not defined in Kconfig=2E  Do nothing=2E
>-   The entry for this CONFIG was not found in Kconfig=2E  The option is =
not
>-   defined in the config header, either=2E  So, this case can be just sk=
ipped=2E
>-
>- - CONFIG\_=2E=2E=2E is not defined in Kconfig (suspicious)=2E  Do nothi=
ng=2E
>-   This option is defined in the config header, but its entry was not fo=
und
>-   in Kconfig=2E
>-   There are two common cases:
>-
>-     - You forgot to create an entry for the CONFIG before running
>-       this tool, or made a typo in a CONFIG passed to this tool=2E
>-     - The entry was hidden due to unmet 'depends on'=2E
>-
>-   The tool does not know if the result is reasonable, so please check i=
t
>-   manually=2E
>-
>- - 'CONFIG\_=2E=2E=2E' is the same as the define in Kconfig=2E  Do nothi=
ng=2E
>-   The define in the config header matched the one in Kconfig=2E
>-   We do not need to touch it=2E
>-
>- - Compiler is missing=2E  Do nothing=2E
>-   The compiler specified for this architecture was not found
>-   in your PATH environment=2E
>-   (If -e option is passed, the tool exits immediately=2E)
>-
>- - Failed to process=2E
>-   An error occurred during processing this defconfig=2E  Skipped=2E
>-   (If -e option is passed, the tool exits immediately on error=2E)
>-
>-Finally, you will be asked, Clean up headers? [y/n]:
>-
>-If you say 'y' here, the unnecessary config defines are removed
>-from the config headers (include/configs/\*=2Eh)=2E
>-It just uses the regex method, so you should not rely on it=2E
>-Just in case, please do 'git diff' to see what happened=2E
>-
>-
> How does it work?
> -----------------
>=20
>-This tool runs configuration and builds include/autoconf=2Emk for every
>-defconfig=2E  The config options defined in Kconfig appear in the =2Econ=
fig
>-file (unless they are hidden because of unmet dependency=2E)
>+When building a database (`-b`), this tool runs configuration and builds
>+include/autoconf=2Emk for every defconfig=2E  The config options defined=
 in Kconfig

How about *=2Econfig fragments?

>+appear in the =2Econfig file (unless they are hidden because of unmet de=
pendency=2E)
> On the other hand, the config options defined by board headers are seen
>-in include/autoconf=2Emk=2E  The tool looks for the specified options in=
 both
>-of them to decide the appropriate action for the options=2E  If the give=
n
>-config option is found in the =2Econfig, but its value does not match th=
e
>-one from the board header, the config option in the =2Econfig is replace=
d
>-with the define in the board header=2E  Then, the =2Econfig is synced by
>-"make savedefconfig" and the defconfig is updated with it=2E
>+in include/autoconf=2Emk=2E
>+
>+When resyncing defconfigs (`-s`) the =2Econfig is synced by "make savede=
fconfig"

%s/resyncing/resynchronizing/

>+and the defconfig is updated with it=2E
>=20
> For faster processing, this tool handles multi-threading=2E  It creates

%s/handles multi-threading/uses parallelization/

> separate build directories where the out-of-tree build is run=2E  The
>@@ -109,7 +46,7 @@ Toolchains
> Appropriate toolchain are necessary to generate include/autoconf=2Emk

%s/toolchain/toolchains/

> for all the architectures supported by U-Boot=2E  Most of them are avail=
able
> at the kernel=2Eorg site, some are not provided by kernel=2Eorg=2E This =
tool uses

That 'some are not =2E=2E=2E' clause is superfluous=2E


>-the same tools as buildman, so see that tool for setup (e=2Eg=2E --fetch=
-arch)=2E
>+the same tools as buildman, so see that tool for setup (e=2Eg=2E `--fetc=
h-arch`)=2E

Are you really referring to other tools than buildman itself? Which tools?

Please, provide a link to the buildman documentation and provide an exampl=
e here=2E


>=20
>=20
> Tips and trips

Do you mean 'Examples'?

Best regards

Heinrich


>@@ -117,32 +54,32 @@ Tips and trips
>=20
> To sync only X86 defconfigs::
>=20
>-   =2E/tools/moveconfig=2Epy -s -d <(grep -l X86 configs/*)
>+   =2E/tools/qconfig=2Epy -s -d <(grep -l X86 configs/*)
>=20
> or::
>=20
>-   grep -l X86 configs/* | =2E/tools/moveconfig=2Epy -s -d -
>+   grep -l X86 configs/* | =2E/tools/qconfig=2Epy -s -d -
>=20
> To process CONFIG_CMD_FPGAD only for a subset of configs based on path m=
atch::
>=20
>    ls configs/{hrcon*,iocon*,strider*} | \
>-       =2E/tools/moveconfig=2Epy -Cy CONFIG_CMD_FPGAD -d -
>+       =2E/tools/qconfig=2Epy -C CONFIG_CMD_FPGAD -d -
>=20
>=20
> Finding boards with particular CONFIG combinations
> --------------------------------------------------
>=20
>-You can use `moveconfig=2Epy` to figure out which boards have a CONFIG e=
nabled, or
>+You can use `qconfig=2Epy` to figure out which boards have a CONFIG enab=
led, or
> which do not=2E To use it, first build a database::
>=20
>-    =2E/tools/moveconfig=2Epy -b
>+    =2E/tools/qconfig=2Epy -b
>=20
> Then you can run queries using the `-f` flag followed by a list of CONFI=
G terms=2E
> Each term is CONFIG name, with or without a tilde (~) prefix=2E The tool=
 searches
> for boards which match the CONFIG name, or do not match if tilde is used=
=2E For
> example, to find boards which enabled CONFIG_SCSI but not CONFIG_BLK::
>=20
>-    tools/moveconfig=2Epy -f SCSI ~BLK
>+    tools/qconfig=2Epy -f SCSI ~BLK
>     3 matches
>     pg_wcom_seli8_defconfig highbank_defconfig pg_wcom_expu1_defconfig
>=20
>@@ -158,11 +95,11 @@ each of the x86 defconfig files=2E
>=20
> This tool can help find such configs=2E To use it, first build a databas=
e::
>=20
>-    =2E/tools/moveconfig=2Epy -b
>+    =2E/tools/qconfig=2Epy -b
>=20
> Then try to query it::
>=20
>-   =2E/tools/moveconfig=2Epy -i CONFIG_I8042_KEYB
>+   =2E/tools/qconfig=2Epy -i CONFIG_I8042_KEYB
>    CONFIG_I8042_KEYB found in 33/5155 defconfigs
>    28 : CONFIG_X86
>    28 : CONFIG_SA_PCIEX_LENGTH
>@@ -193,12 +130,12 @@ indicates that CONFIG_I8042_KEYB is not needed for =
the remaining 5 boards=2E Many
> of the options listed are not suitable as they are not related=2E E=2Eg=
=2E it would be
> odd for CONFIG_RAMBASE to imply CONFIG_I8042_KEYB=2E
>=20
>-Using this search you can reduce the size of moveconfig patches=2E
>+Using this search you can reduce the size of qconfig patches=2E
>=20
> You can automatically add 'imply' statements in the Kconfig with the -a
> option::
>=20
>-    =2E/tools/moveconfig=2Epy -s -i CONFIG_SCSI \
>+    =2E/tools/qconfig=2Epy -s -i CONFIG_SCSI \
>             -a CONFIG_ARCH_LS1021A,CONFIG_ARCH_LS1043A
>=20
> This will add 'imply SCSI' to the two CONFIG options mentioned, assuming=
 that
>@@ -220,7 +157,7 @@ the size of their defconfig files=2E
>=20
> If you want to add an 'imply' to every imply config in the list, you can=
 use::
>=20
>-    =2E/tools/moveconfig=2Epy -s -i CONFIG_SCSI -a all
>+    =2E/tools/qconfig=2Epy -s -i CONFIG_SCSI -a all
>=20
> To control which ones are displayed, use -I <list> where list is a list =
of
> options (use '-I help' to see possible options and their meaning)=2E
>@@ -230,7 +167,7 @@ To skip showing you options that already have an 'imp=
ly' attached, use -A=2E
> When you have finished adding 'imply' options you can regenerate the
> defconfig files for affected boards with something like::
>=20
>-    git show --stat | =2E/tools/moveconfig=2Epy -s -d -
>+    git show --stat | =2E/tools/qconfig=2Epy -s -d -
>=20
> This will regenerate only those defconfigs changed in the current commit=
=2E
> If you start with (say) 100 defconfigs being changed in the commit, and =
add
>@@ -241,9 +178,9 @@ number of defconfigs changed in the commit=2E
> Available options
> -----------------
>=20
>- -c, --color
>-   Surround each portion of the log with escape sequences to display it
>-   in color on the terminal=2E
>+ --nocolour
>+   Disables colouring of output=2E This is normally used when writing to=
 a
>+   terminal=2E
>=20
>  -C, --commit
>    Create a git commit with the changes when the operation is complete=
=2E A
>@@ -275,9 +212,6 @@ Available options
>    because SPL related options (mostly prefixed with CONFIG_SPL\_) are
>    sometimes blocked by CONFIG_SPL_BUILD ifdef conditionals=2E
>=20
>- -H, --headers-only
>-   Only cleanup the headers; skip the defconfig processing
>-
>  -j, --jobs
>    Specify the number of threads to run simultaneously=2E  If not specif=
ied,
>    the number of threads is the same as the number of CPU cores=2E
>@@ -293,10 +227,6 @@ Available options
>  -v, --verbose
>    Show any build errors as boards are built
>=20
>- -y, --yes
>-   Instead of prompting, automatically go ahead with all operations=2E T=
his
>-   includes cleaning up headers, the config whitelist and the README=2E
>-
> To see the complete list of supported options, run::
>=20
>-  tools/moveconfig=2Epy -h
>+  tools/qconfig=2Epy -h
