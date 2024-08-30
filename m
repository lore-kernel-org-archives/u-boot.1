Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD958CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 08:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 255D988D1F;
	Fri, 30 Aug 2024 10:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oWlDsAkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385BD88D1F; Fri, 30 Aug 2024 10:38:24 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A275D88BFC
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 10:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-371893dd249so1109853f8f.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725007101; x=1725611901; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CxTyTsPZ8Afm3vApgvAAlGgl8I+1/Z2dnMMI67EQxt4=;
 b=oWlDsAkd0XC4wksEEz1X3YZHCOu46pp5e4E/wfVuyxUDoPkyJVCf3SPluO9xATnqP9
 Ocd3zZndG0i1VIlL3HrNCGo8o63D/BOxevB47Hv1Ma4DoCIMrnncLsEOgLlk0vd+o0gF
 iX0kW83mSrO76AlUNg/QHpMqXPMXjfBseIbMyfe2wXY5VMBDN8CijXcSaD31qIRLpknc
 RXcJzLFExDerW4kGPK/gZOVAAeh1d01fYA9MN/2Gs5PIlecOWD743RT2cvcW9MJlUMZQ
 M1jYonZ6L6jTGZC3l5/hmw0Ri8mrgDa1qRR642FDTZS7Ata0/l7Eq4o1oshSt6Zbai9b
 J9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725007101; x=1725611901;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CxTyTsPZ8Afm3vApgvAAlGgl8I+1/Z2dnMMI67EQxt4=;
 b=sthgw9WO3AlcgBDzDC9YQKcKocv9L9Or1C26lS9lVhPj1AKAh4CmrcMvzz+SGAH7HZ
 EfvEFx+llBtbJR1E0+SS7fY8zsnsq8vwncXm4ygV+sKybZhwEy4mZaY3Ew7d556Wa08r
 W9AZLlkolheXggoSm9pTEyEpSpsNDwLUk1y6AMZrbKLoAoloVt6CdqaTzwpaZ8hOLdAR
 OsUpgCIlhiYGcO+HSnr8GIgesz/6K9/fr+kYIGwzFi+e/nJHkUPE8yRZ1pr3j3Y6bOJi
 7J6iZc+mp0B3lrsvCcN8+1ShngdmQYyul5kzo0zec1jtS3qyxwqJDZloNIxVPAsUtpju
 vRbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0j4f3qZpo2FOyV0llC+hkZb6wapTd4xHsOJUOlgIjA6/WFeJIXkK7N5zc4fVFSK82TEj7BcY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6GtDA1Q0/msR6a2KtkllJCoCl185HYd4028rSv2d5B8df8Agz
 Fs2rWXx/4n6HiuY1zOOxtXYywLCh/juT1VviiC+vQL5pjNCKzRPHXKJGbKazMc0=
X-Google-Smtp-Source: AGHT+IGJq7dONEFtshiBC3OJxJjdQcJIMdP+Bzmjvp29CMHWweG3tRY8QrNOnosu1IxUROOYBODJpw==
X-Received: by 2002:adf:a341:0:b0:368:74c0:6721 with SMTP id
 ffacd0b85a97d-3749b581becmr3760188f8f.38.1725007100499; 
 Fri, 30 Aug 2024 01:38:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5001:8e1b:dd18:1d3?
 ([2a01:e0a:982:cbb0:5001:8e1b:dd18:1d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749eea50dasm3346194f8f.56.2024.08.30.01.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 01:38:20 -0700 (PDT)
Message-ID: <15a0707b-050e-4d5f-b339-7a73c7652ce8@linaro.org>
Date: Fri, 30 Aug 2024 10:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
 <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
 <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
 <CAFLszTgzM-FT64AYTy6FXwUw3FQg-3MQ7x0TZc6xBhX5c+bXEg@mail.gmail.com>
 <20240829152052.GE2479150@bill-the-cat>
 <CAFLszTjqVsZ1owvpCaOer7U-k0ZvtDfLC9g+kFPW8gJJeQ1Ktw@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAFLszTjqVsZ1owvpCaOer7U-k0ZvtDfLC9g+kFPW8gJJeQ1Ktw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 30/08/2024 03:09, Simon Glass wrote:
> Hi Tom,
> 
> On Thu, 29 Aug 2024 at 09:20, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Aug 29, 2024 at 09:02:38AM -0600, Simon Glass wrote:
>>> Hi Neil,
>>>
>>> On Thu, 29 Aug 2024 at 08:44, <neil.armstrong@linaro.org> wrote:
>>>>
>>>> On 29/08/2024 14:17, Simon Glass wrote:
>>>>> Hi Peter,
>>>>>
>>>>> On Thu, 29 Aug 2024 at 04:43, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>>>
>>>>>> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
>>>>>>>
>>>>>>> Hi Peter,
>>>>>>>
>>>>>>> On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Hi Simon,
>>>>>>>>
>>>>>>>>> With Labgrid we don't need to specify the various methods, except for
>>>>>>>>> the console, which simply calls labgrid-client.
>>>>>>>>>
>>>>>>>>> This allows supporting any boards in your lab, without adding per-board
>>>>>>>>> configuration to these hooks.
>>>>>>>>>
>>>>>>>>> Provide ellesmere files as an example.
>>>>>>>>
>>>>>>>> What's ellesmere?
>>>>>>>
>>>>>>> It is a lake but also the name of a computer.
>>>>>>>
>>>>>>>>
>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Changes in v4:
>>>>>>>>> - Support pytest fully with dual-build boards like Beagleplay
>>>>>>>>>
>>>>>>>>> Changes in v3:
>>>>>>>>> - Update scripts for latest version of Labgrid integration
>>>>>>>>> - Add poweroff.none and poweron.none
>>>>>>>>> - Provide -n flag when querying board info
>>>>>>>>> - Target the grpc version of Labgrid which is now in -master
>>>>>>>>> - Update README to cover the changes
>>>>>>>>>
>>>>>>>>> Changes in v2:
>>>>>>>>> - Make use of the common script (only) to set bin_dir
>>>>>>>>>
>>>>>>>>>    README.md                    | 50 ++++++++++++++++++++++++++++++++++++
>>>>>>>>
>>>>>>>> Maybe that should be in a separate labsgrid readme?
>>>>>>>
>>>>>>> My hope is that Labgrid becomes the normal way of running these tests,
>>>>>>
>>>>>> Generally I agree with automated testing platforms, I think <insert
>>>>>> you're preferred platform here> makes sense, there's a bunch like
>>>>>> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
>>>>>> bunch more that I'm aware of.
>>>>>
>>>>> I am somewhat familiar with LAVA and I believe it can be used to test
>>>>> U-Boot, although I need to learn how. Looking at a test run [2] for
>>>>> beaglebone black I see that it is using a recent kernel but the U-Boot
>>>>> seems to be older.
>>>>>
>>>>>>
>>>>>> Does it make sense, of course at some point in the future post this
>>>>>> being merged, make sense to look at a general way of making it easier
>>>>>> to plugin these sort of HW test platforms using this as a basis? I ask
>>>>>> mostly because putting a bunch of my devices into some sort of
>>>>>> platform can auto test things and of course everyone has an opinion to
>>>>>> which is the best one :-P
>>>>>
>>>>> Yes. I had heard from Tom that Labgrid is the new hotness for now.
>>>>> Having dug into it I believe it is a good solution, although it can
>>>>> certainly be improved to handle scale better.
>>>>>
>>>>> Anyway, IMO the current test hooks are not a great solution, just
>>>>> because the configuration is spread all over the place and it relies
>>>>> on lots of little shell scripts. So I believe that the Labgrid
>>>>> integration is a closer to where we want to be with others that come
>>>>> along.
>>>>
>>>> I'd say all those scripts are actually here to ease integration with any
>>>> system, booting U-Boot and Linux are two different beasts.
>>>
>>> That's fine, go ahead and use the scripts. My point is that Labgrid
>>> doesn't need them and in fact it makes everything pretty painful if we
>>> try to use all of them.
>>
>> I guess I really need to clean-up and post my former co-workers scripts
>> as I strongly disagree with that statement.
> 
> See some examples below. Bear in mind also that my goal has been to
> get my lab fully running, that includes interactive access to boards,
> as well as running tests. For that I have been using tbot (with
> integrated build and software-loading features). WIth Labgrid I have
> been able to replace most of the pytest scripts, tbot and Labman with
> Labgrid + 60 patches and some configuration files.
> 
> Let's look through the scripts:
> 
> u-boot-test-common - new script
> 
> u-boot-test-console - needed
> 
> u-boot-test-flash - here's an example:
> 
> . poweroff.${power_impl}
> sleep 0.1
> . flash.sdwire_common_mount
> . poweron.${power_impl}
> 
> Here's another:
> 
> # Handles the common SDwire mounting (caller does power control)
> 
> mount_dir=/media/${mount_point}
> 
> # Switch over to get USB card access
> sd-mux-ctrl --device-serial ${sdwire_serial} --ts
> 
> complete=false
> for i in {0..9}; do
>      if out="$(mount UUID=${mount_uuid} 2>&1)"; then
>          complete=true
>          break
>      fi
>      echo $out
> 
>      # If it is already mounted, try to unmount it first. It may have been
>      # mounted by another user so we won't have the access we need. If this gives
>      # an error then we know we cannot continue
>      if [[ $out == *"already mounted"* ]]; then
>          umount UUID=${mount_uuid}
>      fi
>      sleep 1
> done
> if [[ $complete = false ]]; then
>      echo "Failed to mount UUID ${mount_uuid} after 10 tries"
>      exit 1
> fi
> 
> # Sanity check
> if ! mountpoint -q ${mount_dir}; then
>      echo "Mount ${mount_dir} not available after 'mount'"
>      exit 1
> fi
> 
> # Perform the write, pass along as much environment as possible
> . writer.${flash_writer}
> 
> complete=false
> for i in {0..9}; do
>      if out="$(umount ${mount_dir} 2>&1)"; then
>          complete=true
>          break
>      fi
>      echo $out
>      sleep 1
> done
> 
> if [[ $complete = false ]]; then
>      echo "Failed to umount UUID ${mount_uuid} after 10 tries"
>      exit 1
> fi
> 
> # Sanity check
> if mountpoint -q ${mount_dir}; then
>      echo "Mount ${mount_dir} still available after 'umount'"
>      exit 1
> fi
> 
> # Back to card access for the DUT
> sd-mux-ctrl --device-serial ${sdwire_serial} --dut
> 
> 
> Of course that assumes an SDwire which may not always be the case.
> Abstracting all of this into shell scripts is just too painful. Also I
> have found it to be error-prone.
> 
> There is also bin/flash.sdwire_relay_mount:
> 
> . poweroff.${power_impl}
> 
> sleep 0.1
> 
> . flash.sdwire_common_mount
> 
> . poweron.${power_impl}
> 
> 
> u-boot-test-getrole
> - New script
> 
> u-boot-test-power-off
> - This one fits with Labgrid quite well, but of course there may not
> actually be power control
> 
> u-boot-test-power-on
> - This one also fits with Labgrid, but since serial output can come
> out as soon as it is called, jumping back into Labgrid later to bring
> up a console results in lots of missing output. Also there may not
> actually be power control
> 
> u-boot-test-release
> - New script. Actually this isn't really needed, since I added
> automatic release to Labgrid. I was just worried that Labgrid might
> crash
> 
> u-boot-test-reset
> - Unfortunately labgrid doesn't provide a reset option, although I'm
> sure it could be added. You still need to know whether to use power or
> reset or both, though, so again you have shell scripts with this stuff
> 
> reset.recovery_download - another thing I had to add, BTW
> 
> . "${bin_dir}/recovery.${recovery_impl}"
> 
> # USB enumeration delay
> for ((i = 0; i <= 100; i++)); do
>      if [ -e "${board_usb_dev}" ]; then
>          break
>      fi
>      sleep 0.1
> done
> if [ ! -e "${board_usb_dev}" ]; then
>      echo "Cannot find device ${board_usb_dev}"
>      exit 1
> fi
> sleep 1
> 
> . "${bin_dir}/download.${download_impl}"
> 
> or another case, this is Zynq which tries to wait a bit before calling
> picocom. It mostly works, but it loses output
> 
> # Some boards have a UART built into them and it doesn't appear until the
> # board is powered on. An example is zynq_zybo. Try to handle this by waiting
> # for the console and then continuing as soon as possible (so we don't miss
> # the U-Boot banner).
> if [ -n "${console_wait}" ]; then
>      for i in {0..99}; do
>          if [ -e "${console_dev}" ]; then
>              break
>          fi
>          sleep .1
>      done
>      if [ ! -e "${console_dev}" ]; then
>          echo "Console ${console_dev} not found"
>          exit 1
>      fi
> fi
> 
> exec picocom -b "${console_baud}" "${console_dev}"
> 
> So that's about a third of the reason why I don't think the scripts scale.

My integration requires only this file:

bin/console.abcd
====><============
FIP_DIR=`mktemp -d`
￼
￼pushd ${boot_fip_dir}
￼./build-fip.sh ${boot_fip_board} ${U_BOOT_BUILD_DIR}/u-boot.bin ${FIP_DIR}
￼cp ${FIP_DIR}/u-boot.bin ${U_BOOT_BUILD_DIR}/u-boot.bin.abcd
￼popd
￼rm -rf ${FIP_DIR}
￼
￼exec "${abcd_binary}" -h ${abcd_host} -b ${abcd_board} ${abcd_extra_args} ${U_BOOT_BUILD_DIR}/u-boot.bin.abcd
====><============

the abcd_binary does all the dirty work, connecting the the server and connecting the board
TTY to stdout, and the server does all the dirty power-up and loading u-boot to memory.

I still wonder why you need so much changes if labgrid is so simple.

For LAVA, it would likely very similar, exact we should generate a job to load
u-boot, submit it and somehow interact with the board.

Neil

> 
>> The only "painful" part is
>> the shared pain, regardless of framework, for "put blob $X at location
>> $Y", which I believe you abstract out in to python?
> 
> Sort-of. The Python knows how to handle all the different writing
> methods and is at [2], but it is entirely controlled by yaml[3] (the
> example_env.yaml). See the ti,am625 method for example and the 'play'
> board right at the bottom of the end file.
> 
> I very much like the configuration files (although I hope one day
> Labgrid will allow the two files to be combined). It makes it easier
> to add a new board, since there is much less to think about. It really
> did take a long time to fiddle with all those hook scripts and I got
> tired of it.
> 
> Regards,
> Simon
> 
> [1] https://github.com/sjg20/u-boot/tree/lab6a/tools/labman
> [2] https://github.com/labgrid-project/labgrid/pull/1411/commits/c7ea03987362af70bbbb94d14ff74c54a1ee5ed8#diff-e994502495dc8083c0b70ab20ace18fb5f85217805d01a54270a69c84ec31023R107
> [3] https://github.com/labgrid-project/labgrid/pull/1411/commits/6d3b4a0cfc7e35e0547dcd14065328df4b4b5e1f#diff-66f82743402c95b2eac8f9937c61c582bd0aca2b35e841477d62122c811b7750R1187

